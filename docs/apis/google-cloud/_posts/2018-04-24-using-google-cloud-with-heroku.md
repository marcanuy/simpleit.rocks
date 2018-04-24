---
description: Use Google Cloud Platform from heroku. A short guide to add credentials to an environment variable in Heroku
image: /assets/img/googletexttospeech_api.jpg
---

## Overview

Using Google Cloud Platform requires that you set up your *keys* to
make use of the API, and the only supported method for that is to
generate a credentials file and refer to it using the environment
variable `GOOGLE_APPLICATION_CREDENTIALS`.

We will see how to load credentials in Heroku, using this file as an
environment variable.

In this guide I will by using Google Cloud's Python client with the
Text-to-speech API but any other service or programming language
should be pretty similar to this method.

## Load data in env var

After creating a service account key, we will have a credentials file
in json format looking like this:

~~~ json
{
  "type": "service_account",
  "project_id": "marcanuy-XXXXXX",
  "private_key_id": "XXXXXXXXXXXXX",
  "private_key": "-----BEGIN PRIVATE KEY-----\nXXXXXXXXXX\n-----END PRIVATE KEY-----\n",
  "client_email": "XXXX-service-account@marcanuy-XXXXXX.iam.gserviceaccount.com",
  "client_id": "XXXX",
  "auth_uri": "https://accounts.google.com/o/oauth2/auth",
  "token_uri": "https://accounts.google.com/o/oauth2/token",
  "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
  "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/equilang-service-account%40marcanuy-XXXXX.iam.gserviceaccount.com"
}
~~~

This is the file Google ask us to point it at, using the environment variable
`GOOGLE_APPLICATION_CREDENTIALS`.

> Set the environment variable GOOGLE_APPLICATION_CREDENTIALS to the
> file path of the JSON file that contains your service account key.
> 
> <footer class="blockquote-footer"> <cite><a href="https://cloud.google.com/text-to-speech/docs/reference/libraries#client-libraries-install-python">Text-to-Speech API Client Libraries</a></cite></footer>
{: class="blockquote" cite="https://cloud.google.com/text-to-speech/docs/reference/libraries#client-libraries-install-python"}

But instead of doing that, we load its contents in it: <kbd>"$(< credentials.json)"</kbd>

<pre class="shell">
<samp>
<span class="shell-prompt">$</span> <kbd>export GOOGLE_APPLICATION_CREDENTIALS="$(< credentials.json)"</kbd>
</samp>
</pre>

Now we have the file contents in the variable, we can verify it with <kbd>echo $GOOGLE_APPLICATION_CREDENTIALS</kbd>:

<pre class="shell">
<samp>
<span class="shell-prompt">$</span> <kbd>echo $GOOGLE_APPLICATION_CREDENTIALS</kbd>
{ "type": "service_account", "project_id": "marcanuy-XXXXX", "private_key_id": "XXXXXX", "private_key": "-----BEGIN PRIVATE KEY-----\nXXXXXX\n-----END PRIVATE KEY-----\n", "client_email": "equilang-service-account@marcanuy-XXXX.iam.gserviceaccount.com", "client_id": "XXXXXX", "auth_uri": "https://accounts.google.com/o/oauth2/auth", "token_uri": "https://accounts.google.com/o/oauth2/token", "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs", "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/equilang-service-account%40marcanuy-XXXXXXX.iam.gserviceaccount.com" }
</samp>
</pre>

## Using the client

Now we use the client but instead of letting it automatically loading
the above data, we pass it as an argument to the constructor.

Google's text to speech client `google.cloud.texttospeech_v1beta1.gapic.text_to_speech_client.TextToSpeechClient` is defined like:

~~~ python
class TextToSpeechClient(object):
    """Service that implements Google Cloud Text-to-Speech API."""

    def __init__(self,
                 channel=None,
                 credentials=None,
                 client_config=text_to_speech_client_config.config,
                 client_info=None):
~~~

It accepts an instance of `google.auth.credentials.Credentials`, to
generate an instance of this class we use `google.oauth2.service_account.Credentials.from_service_account_info`:

~~~ python
class Credentials(credentials.Signing,
                  credentials.Scoped,
                  credentials.Credentials):
    """Service account credentials
	
	# ....
	
    @classmethod
    def from_service_account_info(cls, info, **kwargs):
        """Creates a Credentials instance from parsed service account info.

        Args:
            info (Mapping[str, str]): The service account info in Google
                format.
            kwargs: Additional arguments to pass to the constructor.

        Returns:
            google.auth.service_account.Credentials: The constructed
                credentials.

        Raises:
            ValueError: If the info is not in the expected format.
        """
        signer = _service_account_info.from_dict(
            info, require=['client_email', 'token_uri'])
        return cls._from_signer_and_info(signer, info, **kwargs)
~~~




Read credential data from environment variable:

~~~ python
import os
credentials_raw = os.environ.get('GOOGLE_APPLICATION_CREDENTIALS')
~~~

Generate credentials:

~~~ python
from google.oauth2 import service_account
import json
service_account_info = json.loads(credentials_raw)
credentials = service_account.Credentials.from_service_account_info(
    service_account_info)
~~~

Define a client using the above credentials, in this case Google's
text to speech client:

~~~ python
from google.cloud import texttospeech
client = texttospeech.TextToSpeechClient(credentials=credentials)
~~~

## Testing code

Putting it all together:

~~~ python
from google.oauth2 import service_account
from google.cloud import texttospeech
import os
import json

def synthesize_text(text):
    """Synthesizes speech from the input string of text."""

    input_text = texttospeech.types.SynthesisInput(text=text)

    # Note: the voice can also be specified by name.
    # Names of voices can be retrieved with client.list_voices().
    voice = texttospeech.types.VoiceSelectionParams(
        language_code='en-US',
        ssml_gender=texttospeech.enums.SsmlVoiceGender.FEMALE)

    audio_config = texttospeech.types.AudioConfig(
        audio_encoding=texttospeech.enums.AudioEncoding.MP3)

    response = client.synthesize_speech(input_text, voice, audio_config)

    # The response's audio_content is binary.
    with open('output.mp3', 'wb') as out:
        out.write(response.audio_content)
        print('Audio content written to file "output.mp3"')

# Read env data
credentials_raw = os.environ.get('GOOGLE_APPLICATION_CREDENTIALS')

# Generate credentials
service_account_info = json.loads(credentials_raw)
credentials = service_account.Credentials.from_service_account_info(
    service_account_info)

# Define a client, in this case Google's text to speech
client = texttospeech.TextToSpeechClient(credentials=credentials)

# Test client
synthesize_text("hello world")
~~~

And we have a nice request in out Google Cloud's Platform chart:

![Google Cloud Dashboard](/assets/img/googletexttospeech_api.jpg 'Google Cloud Dashboard'){:class="img-fluid"}


## In Heroku

To set the environment variables in Heroku use <kbd>heroku
config:set</kbd>


<pre class="shell">
<samp>
<span class="shell-prompt">$</span> <kbd>heroku config:set GOOGLE_APPLICATION_CREDENTIALS="$(< credentials.json)"</kbd>

</samp>
</pre>

## Conclusion

Google Cloud's API is still on Beta, there is a lot of room for improvement here
so it won't surprise me if there is a **cleaner* solution in a short
time, but for now this is the best method I came up with to make
Heroku and Google Cloud play nice together.

## References

- [Text-to-Speech API Client Libraries](https://cloud.google.com/text-to-speech/docs/reference/libraries#client-libraries-install-python)
- [Load JSON file's content on Heroku?
  #78](https://github.com/google/google-auth-library-ruby/issues/78#issuecomment-237380364)
- <https://docs.python.org/3.6/library/json.html>
- [How to send a multiline file to Heroku Config](https://coreyward.svbtle.com/how-to-send-a-multiline-file-to-heroku-config)
- [GoogleCloudPlatform/python-docs-samples](https://github.com/GoogleCloudPlatform/python-docs-samples/blob/master/texttospeech/cloud-client/synthesize_text.py)
