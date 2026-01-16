SRC_DIR			:= src
SRC 			:= \
					$(SRC_DIR)/README.md
TEMPLATE_MD		:= $(SRC_DIR)/template/md.tex
TEMPLATE_PDF	:= $(SRC_DIR)/template/pdf.tex
MD_FILES		:= $(patsubst $(SRC_DIR)/%.md,%.md,$(SRC))
PDF_FILES 		:= $(patsubst $(SRC_DIR)/%.md,%.pdf,$(SRC))

all: $(MD_FILES) $(PDF_FILES)

%.md: $(SRC_DIR)/%.md
	mkdir -p $(dir $@)
	pandoc --template $(TEMPLATE_MD) -t gfm --shift-heading-level-by=1 --toc $< -o $@

%.pdf: $(SRC_DIR)/%.md
	mkdir -p $(dir $@)
	pandoc --template $(TEMPLATE_PDF) $< -o $@

clean:
	rm -f $(MD_FILES) $(PDF_FILES)

re: clean all

.PHONY: docs clean re