import boto3
import json
import logging
import os
import random
import string

logger = logging.getLogger()
logger.setLevel(logging.INFO)

secretsmanager = boto3.client('secretsmanager')

def generate_random_secret(length=16):
    """Génère une nouvelle valeur secrète aléatoire."""
    characters = string.ascii_letters + string.digits + "!@#$%^&*()"
    return ''.join(random.choice(characters) for i in range(length))

def lambda_handler(event, context):
    """Gère la rotation des secrets."""
    secret_arn = event['SecretId']
    step = event['Step']
    
    if step == "createSecret":
        new_secret = generate_random_secret()
        secretsmanager.put_secret_value(
            SecretId=secret_arn,
            SecretString=new_secret
        )
        logger.info(f"Nouvelle valeur secrète générée pour {secret_arn}")

    elif step == "setSecret":
        logger.info(f"Le secret {secret_arn} est prêt à être utilisé.")

    elif step == "testSecret":
        logger.info(f"Test de validation du secret {secret_arn}.")

    elif step == "finishSecret":
        logger.info(f"Finalisation de la rotation pour {secret_arn}.")
    
    return {"status": "success"}
