while getopts "p:" opt; do
  case $opt in
    p) port="$OPTARG"
    ;;
    \?) echo "Invalid option -$OPTARG" >&2
    exit 1
    ;;
  esac

  case $OPTARG in
    -*) echo "Option $opt needs a valid argument"
    exit 1
    ;;
  esac
done

echo "Build code generation tool"

echo "Use swagger local port = $port"

echo "Download openapi JSON file..."

wget "http://127.0.0.1:$port/export/openapi/2?version=3.0" \
  -O swaggers/announcement_api.json

echo "Delete preview generation files..."