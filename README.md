# Find_Latest_WorkflowId_In_S3_BucketFiles

Some of the Customers were aborted in performance testing due to the old s3 sync up issue. The reason is Json file has latest workflow id but the s3 bucket file has old workflow id since s3 sync hasn't done recently.   

This can be resolved in 2 ways  

1.Sync s3 bucket - takes more time

2.In order to reduce time effort find the old workflow id and management id for those aborted customer id.

This is the code for the 2nd way, it will find out the wfid for the latest JSON file uploaded 

Language: _powershell and AWS CLI_

Install powershell on MAC: **_brew install --cask powershell_**
