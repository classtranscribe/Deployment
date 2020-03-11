CURR_PATH="/curr_dir"
sample_file=`cat $CURR_PATH/sample-environment-variable-file.env`

# Set DATA variable to test_data 
TEMP_VAR="./test_data"
sample_file="${sample_file/<DATA>/$TEMP_VAR}"

# Set HOST_NAME variable to localhost
TEMP_VAR="localhost"
sample_file="${sample_file/<HOST_NAME>/$TEMP_VAR}"

# Set ADMIN_USER_ID variable to default value
TEMP_VAR="myadmin@example.com"
sample_file="${sample_file/<ADMIN_USER_ID>/$TEMP_VAR}"

# Set ADMIN_PASSWORD variable to random string
ADMIN_PASSWORD=`openssl rand -base64 16`
sample_file="${sample_file/<ADMIN_PASSWORD>/$ADMIN_PASSWORD}"

# Set JWT_KEY variable to random string
TEMP_VAR=`openssl rand -base64 32`
sample_file="${sample_file/<JWT_KEY>/$TEMP_VAR}"

# Set PORTAINER_PASSWORD variable to hash of ADMIN_PASSWORD
TEMP_VAR=`htpasswd -nbB admin "$ADMIN_PASSWORD" | cut -d ":" -f 2`
sample_file="${sample_file/<PORTAINER_PASSWORD>/$TEMP_VAR}"

printf "%s\n" "$sample_file" > "$CURR_PATH/.env"