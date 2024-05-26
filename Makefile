# Set env var SAXON to point to a recent version
# of https://www.saxonica.com/download/download_page.xml

.PHONY : txt

default:
	@echo "Targets: txt - convert .xml to .txt files"

txt:
	java -jar ${SAXON} \
	-it \
	-xsl:xmltools/xsl/ar2txt.xsl;

status:
	java -jar ${SAXON} \
	-it \
	-xsl:xmltools/xsl/status.xsl;

