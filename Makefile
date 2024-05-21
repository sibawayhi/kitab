# Set env var SAXON to point to a recent version
# of https://www.saxonica.com/download/download_page.xml

.PHONY : txt

default:
	@echo "Targets: txt - convert .xml to .txt files"

txt:
	java -jar ${SAXON} \
	-it \
	-xsl:xsl/ar2txt.xsl;

