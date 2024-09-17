# Build PrimaryVPC
aws cloudformation create-stack --stack-name PrimaryVPC --template-body file://../cloudformation/cd1908-project-stack.yaml --region us-east-1
aws cloudformation wait stack-create-complete --stack-name PrimaryVPC

# get RDSDatabase of PrimaryVPC
$PRIMARY_RDS_ARN=$(aws cloudformation describe-stacks --stack-name PrimaryVPC --query "Stacks[0].Outputs[?OutputKey=='RDSDatabaseArn'].OutputValue[]" --region us-east-1 --output text)

# Build SecondaryVPC
aws cloudformation create-stack --stack-name SecondaryVPC --template-body file://../cloudformation/cd1908-project-stack-secondary.yaml --region us-west-2 --parameters `
ParameterKey=RDSDatabase,ParameterValue=$PRIMARY_RDS_ARN
aws cloudformation wait stack-create-complete --stack-name SecondaryVPC




