# jpatelcolo/ASGinexpanseTokenRefreshUS04/ASGinexpanseTokenRefreshUS04.py

import os, json, configparser, boto3
import requests

client = boto3.client('ssm')
ssm_parameter_path = '/prod/expanseParams'

tokenParameters = client.get_parameter(
    Name='/prod/expanseParams/ASGinExpanseAccess',
    WithDecryption=True
)

accessToken = tokenParameters['Parameter']['Value']

tokenParameters = client.get_parameter(
    Name='/prod/expanseParams/ASGinExpanseRefresh',
    WithDecryption=True
)

refreshToken = tokenParameters['Parameter']['Value']

url = "https://expanse.desire2learn.com/api/token/usertoken"
headers = {'Content-Type':'application/x-www-form-urlencoded', 'x-access-token':accessToken}
body = {'refreshToken':refreshToken}

response = requests.put(url, headers=headers, data=body, verify=False)
jsonResponse = response.json()

refreshToken = jsonResponse['refreshToken']
accessToken = jsonResponse['accessToken']

delete = client.delete_parameter(
    Name='/prod/expanseParams/ASGinExpanseAccess'
)

delete = client.delete_parameter(
    Name='/prod/expanseParams/ASGinExpanseRefresh'
)

response = client.put_parameter(
    Name='/prod/expanseParams/ASGinExpanseAccess',
    Value=accessToken,
    Type='SecureString',
    KeyId='c65e3b54-39f3-4f80-9644-192f41307c81'
)

response = client.put_parameter(
    Name='/prod/expanseParams/ASGinExpanseRefresh',
    Value=refreshToken,
    Type='SecureString',
    KeyId='c65e3b54-39f3-4f80-9644-192f41307c81'
)

def lambda_handler(event, context):

    # TODO implement
    return {
        'statusCode': 200,
        'body': json.dumps('Expanse Tokens Refreshed Successfully')
    }
