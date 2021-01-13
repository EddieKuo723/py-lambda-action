#!/bin/bash
set -e

publish_function_code(){
	echo "Deploying the code itself..."
	zip -r code.zip . -x \*.git\*
	aws lambda update-function-code \
	--function-name "${INPUT_LAMBDA_FUNCTION_NAME}" \
	--zip-file fileb://code.zip
}

update_function_layers(){
	echo "Using the layer in the function..."
	aws lambda update-function-configuration \
	--function-name "${INPUT_LAMBDA_FUNCTION_NAME}" \
	--layers "${INPUT_LAMBDA_LAYER_ARN}" \
	--environment "${INPUT_LAMBDA_VARIABLES}"
}

deploy_lambda_function(){
	publish_function_code
	update_function_layers
}

deploy_lambda_function
echo "Done."
