#!/bin/sh

ID="AKfycbwmc3I2ZfMBE9f8tvkJCvwWDb3hYPVWn3AzNr-kr6-tZNCJVspuhftOxmFJ7ONWMesF"

echo "Generate i18n data from google sheet"

for locale in "en" "zh_TW"
do
  wget "https://script.google.com/macros/s/${ID}/exec?locale=${locale}" \
  -O lib/l10n/intl_${locale}.arb
done

echo "Generate successful"