URLS="https://www.guvi.in guvi.in"
for URL in $URLS
do
	echo $URL
     HTTP_STATUS=$(curl -o /dev/null -s -w "%{http_code}" "$URL")
    if [ $HTTP_STATUS -eq 200 ]
    then
    echo "Success! It gives (HTTP status code: $HTTP_STATUS) for $URL"
else
    echo "Failure! It gives  (HTTP status code: $HTTP_STATUS) for $URL"
fi
done

