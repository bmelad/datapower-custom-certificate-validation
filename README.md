# Custom Certificate Validation

The IBM DataPower Gateway has an out-of-the-box machanism for client certificates validation, but the certificate should arrived as a part of the SSL/TLS handshake or inside a message signature.
There are some special situations which require to pass the certificate inside an HTTP header and still validate them before processing the transaction.


## How to use it?

Just drag the xsl file as a transform action into your pipeline, set the INPUT and OUTPUT contexts to NULL, fill the relevant parameters under the 'Advanced' tab and you're good-to-go.
