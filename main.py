"""
=============================================================
FILE:    main.py
PROJECT: A25 – Data Pipeline 1
AUTHOR:  Member 4 – Developer & Technical Writer
PURPOSE: Load, parse, validate an XML file against an XSD
         schema, and apply XSL stylesheets to produce
         HTML, XML and JSON outputs.
LIBRARY: lxml  (pip install lxml)
=============================================================
"""

# --- Standard library imports ---
import os
import sys

# --- lxml imports for XML parsing, validation and XSLT ---
from lxml import etree


# =============================================================
# SECTION 1 – HELPER FUNCTIONS
# =============================================================

def load_xml(xml_path: str) -> etree._ElementTree:
    """
    Load and parse an XML file from disk.

    Args:
        xml_path: Path to the .xml file.

    Returns:
        A parsed lxml ElementTree object.

    Raises:
        SystemExit: If the file is missing or not well-formed XML.
    """
    if not os.path.isfile(xml_path):
        print(f"[ERROR] XML file not found: {xml_path}")
        sys.exit(1)

    try:
        tree = etree.parse(xml_path)
        print(f"[OK]    Parsed XML file: {xml_path}")
        return tree
    except etree.XMLSyntaxError as e:
        print(f"[ERROR] XML is not well-formed: {e}")
        sys.exit(1)


def load_xsd(xsd_path: str) -> etree.XMLSchema:
    """
    Load an XSD schema file and compile it into an XMLSchema
    validator object.

    Args:
        xsd_path: Path to the .xsd file.

    Returns:
        A compiled lxml XMLSchema object.

    Raises:
        SystemExit: If the file is missing or the schema is invalid.
    """
    if not os.path.isfile(xsd_path):
        print(f"[ERROR] XSD file not found: {xsd_path}")
        sys.exit(1)

    try:
        xsd_tree = etree.parse(xsd_path)
        schema = etree.XMLSchema(xsd_tree)
        print(f"[OK]    Loaded XSD schema: {xsd_path}")
        return schema
    except etree.XMLSchemaParseError as e:
        print(f"[ERROR] XSD schema is invalid: {e}")
        sys.exit(1)


def validate_xml(xml_tree: etree._ElementTree,
                 schema: etree.XMLSchema,
                 xml_path: str) -> bool:
    """
    Validate a parsed XML document against a compiled XSD schema.
    Prints all validation errors if any are found.

    Args:
        xml_tree: The parsed XML document (ElementTree).
        schema:   The compiled XMLSchema validator.
        xml_path: Path string used only for display messages.

    Returns:
        True if the XML is valid, False otherwise.
    """
    is_valid = schema.validate(xml_tree)

    if is_valid:
        print(f"[OK]    XML is VALID against the schema.")
    else:
        print(f"[FAIL]  XML is INVALID against the schema.")
        # Print every validation error with its line number
        for error in schema.error_log:
            print(f"        Line {error.line}: {error.message}")

    return is_valid


def load_xslt(xsl_path: str) -> etree.XSLT:
    """
    Load an XSL stylesheet and compile it into an XSLT
    transformer object.

    Args:
        xsl_path: Path to the .xsl file.

    Returns:
        A compiled lxml XSLT object.

    Raises:
        SystemExit: If the file is missing or the stylesheet
                    contains syntax errors.
    """
    if not os.path.isfile(xsl_path):
        print(f"[ERROR] XSL file not found: {xsl_path}")
        sys.exit(1)

    try:
        xsl_tree = etree.parse(xsl_path)
        transformer = etree.XSLT(xsl_tree)
        return transformer
    except etree.XSLTParseError as e:
        print(f"[ERROR] Could not compile stylesheet {xsl_path}: {e}")
        sys.exit(1)


def apply_xslt_to_xml(xml_tree: etree._ElementTree,
                       transformer: etree.XSLT,
                       output_path: str) -> None:
    """
    Apply an XSLT stylesheet to an XML document and write the
    result as an XML file (binary mode, with pretty-printing).

    Used for stylesheets 7 and 8 which output XML format.

    Args:
        xml_tree:    The parsed input XML document.
        transformer: The compiled XSLT transformer.
        output_path: Path where the output file will be written.
    """
    try:
        result = transformer(xml_tree)
        with open(output_path, "wb") as f:
            # pretty_print adds indentation for readability
            f.write(etree.tostring(result, pretty_print=True,
                                   xml_declaration=True,
                                   encoding="UTF-8"))
        print(f"[OK]    Output written (XML)  -> {output_path}")
    except etree.XSLTApplyError as e:
        print(f"[ERROR] XSLT transformation failed for {output_path}: {e}")


def apply_xslt_to_text(xml_tree: etree._ElementTree,
                        transformer: etree.XSLT,
                        output_path: str) -> None:
    """
    Apply an XSLT stylesheet to an XML document and write the
    result as a plain text file (UTF-8).

    Used for stylesheets 9 and 10 which output JSON text.

    Args:
        xml_tree:    The parsed input XML document.
        transformer: The compiled XSLT transformer.
        output_path: Path where the output file will be written.
    """
    try:
        result = transformer(xml_tree)
        with open(output_path, "w", encoding="utf-8") as f:
            # str(result) converts the XSLT result tree to a string
            f.write(str(result))
        print(f"[OK]    Output written (text) -> {output_path}")
    except etree.XSLTApplyError as e:
        print(f"[ERROR] XSLT transformation failed for {output_path}: {e}")


# =============================================================
# SECTION 2 – CONFIGURATION
# =============================================================

# Input files produced by Members 1, 2, 3
XML_FILE = "sportsclub.xml"   # The XML database (Member 1)
XSD_FILE = "sportsclub.xsd"  # The XML schema  (Member 1)

# XSLT stylesheets and their expected output files
# Each entry: (stylesheet path, output path, output type)
# output type: "xml"  → write binary XML with declaration
#              "text" → write plain text (JSON)
TRANSFORMATIONS = [
    # Stylesheet 7: Member contact list → XML format
    ("stylesheet_7.xsl",  "output_7.xml",  "xml"),

    # Stylesheet 8: Training session schedule → XML format
    ("stylesheet_8.xsl",  "output_8.xml",  "xml"),

    # Stylesheet 9: Bookings → JSON format
    ("stylesheet_9.xsl",  "output_9.json", "text"),

    # Stylesheet 10: Equipment inventory → JSON format
    ("stylesheet_10.xsl", "output_10.json","text"),
]


# =============================================================
# SECTION 3 – MAIN PIPELINE
# =============================================================

def main():
    """
    Main entry point.

    Pipeline steps:
      1. Parse the XML database file.
      2. Load and compile the XSD schema.
      3. Validate the XML against the schema.
      4. For each XSLT stylesheet, apply the transformation
         and save the result to the corresponding output file.
    """

    print("=" * 55)
    print("  A25 – Sports Club XML Pipeline")
    print("=" * 55)

    # ----------------------------------------------------------
    # STEP 1: Parse the XML database
    # ----------------------------------------------------------
    print("\n[STEP 1] Parsing XML database...")
    xml_tree = load_xml(XML_FILE)

    # ----------------------------------------------------------
    # STEP 2: Load the XSD schema
    # ----------------------------------------------------------
    print("\n[STEP 2] Loading XSD schema...")
    schema = load_xsd(XSD_FILE)

    # ----------------------------------------------------------
    # STEP 3: Validate the XML against the XSD schema
    # ----------------------------------------------------------
    print("\n[STEP 3] Validating XML against XSD schema...")
    is_valid = validate_xml(xml_tree, schema, XML_FILE)

    # We still run transformations even if validation fails,
    # but we warn the user so they can fix the XML if needed.
    if not is_valid:
        print("\n[WARN]  Continuing despite validation errors.")
        print("        Fix the XML or XSD before final submission.\n")

    # ----------------------------------------------------------
    # STEP 4: Apply all XSLT stylesheets
    # ----------------------------------------------------------
    print("\n[STEP 4] Applying XSLT stylesheets...")
    print("-" * 55)

    for xsl_path, output_path, output_type in TRANSFORMATIONS:
        # Load and compile the stylesheet
        transformer = load_xslt(xsl_path)

        # Apply the transformation with the correct writer
        if output_type == "xml":
            apply_xslt_to_xml(xml_tree, transformer, output_path)
        else:
            # output_type == "text" (JSON, CSV, plain text, etc.)
            apply_xslt_to_text(xml_tree, transformer, output_path)

    # ----------------------------------------------------------
    # DONE
    # ----------------------------------------------------------
    print("-" * 55)
    print(f"\n[DONE]  All {len(TRANSFORMATIONS)} transformations completed.")
    print("        Check the output files listed above.\n")


# =============================================================
# Entry point guard – allows importing this module without
# running the pipeline automatically.
# =============================================================
if __name__ == "__main__":
    main()
