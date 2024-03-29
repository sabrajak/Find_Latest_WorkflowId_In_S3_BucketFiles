
Remove-Variable -name customerId,wfid,latestDate,latestWfid,date,cust_array -ErrorAction SilentlyContinue

#input
$cust_array="oY2DRU6B1ys109","73Yj5tAjXOH85l";

try{
	for($j=0;$j -lt $cust_array.length ;$j++)
	{
		$customerId=$cust_array[$j];
		$wfid="";
		$latestDate="2020-10-23";
		$latestWfid="";

		$a=aws s3 ls "s3://cp-asset-data-export-cluster02-usw2-cx-nprd-dev/csv/customerId=$customerId/" --profile cx-nprd-dev01 
		echo ("=> Total length of WFID on customer-" +$customerId+" : "+ $a.length)  ;
		for ($i = 0; $i -le $a.length-1; $i +=1)
		{
		    $wfid= $a[$i].Split("=")[1].split("/")[0].trim();
		   
		    $date=aws s3 ls "s3://cp-asset-data-export-cluster02-usw2-cx-nprd-dev/csv/customerId=$customerId/wfId=$wfid/networkelement_sum_vw/" --profile cx-nprd-dev01 | Sort-Object -Property "Last modified" -Descending  | awk '{print $1,$2}'

		    #Remove next 3 lines if not required
		    echo ("=> latestDate:" + (get-date $latestDate)) ;
			echo ("=> iterating date:" + (get-date $date)) ;
			echo ("=> iterating WFID:" + $wfid) ;


			if((get-date $latestDate)  -lt (get-date $date) )
			{
				$latestDate=$date;
				$latestWfid=$wfid;
			}	
			echo ">>itr- $i";
		}

		echo ("==============RESULT===============") ;
		echo ("=> customerId:" + $customerId) ;
		echo ("=> latestWfid:" + $latestWfid) ;
		echo ("=> latestDate:" + $latestDate) ;
		echo ("==============******===============`n") ;
	}

	}catch [System.SystemException] {
	  Write-Host "An error occurred:"
	  Write-Host $_.ScriptStackTrace
	} 
