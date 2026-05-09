from lxml import etree

def transform_to_xml(xml_file, xsl_file, output_file):
    xml  = etree.parse(xml_file)
    xslt = etree.parse(xsl_file)
    transform = etree.XSLT(xslt)
    result    = transform(xml)
    with open(output_file, "wb") as f:
        f.write(etree.tostring(result, pretty_print=True))
    print("OK: " + output_file + " created")

def transform_to_text(xml_file, xsl_file, output_file):
    xml  = etree.parse(xml_file)
    xslt = etree.parse(xsl_file)
    transform = etree.XSLT(xslt)
    result    = transform(xml)
    with open(output_file, "w", encoding="utf-8") as f:
        f.write(str(result))
    print("OK: " + output_file + " created")

print("Starting transformations...")

transform_to_xml("sportsclub.xml", "stylesheet_7.xsl", "output_7.xml")
transform_to_xml("sportsclub.xml", "stylesheet_8.xsl", "output_8.xml")
transform_to_text("sportsclub.xml", "stylesheet_9.xsl", "output_9.json")
transform_to_text("sportsclub.xml", "stylesheet_10.xsl", "output_10.json")

print("All done! 4 files created.")