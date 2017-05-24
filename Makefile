# ����������ļ����ļ�������������չ����
JOBNAME = sample
# ���������ֵ����Ϊ latex��pdflatex �� xelatex��
LATEX = latex
BIBTEX = bibtex
DVIPDF = dvipdfmx

# ����� LaTeX ���룬��ʹ�� dvipdfmx �� dvi ת�� pdf��
ifeq ($(LATEX), latex)
	DODVIPDF = $(DVIPDF) $(JOBNAME)
endif

# ������ Windows ���������� UNIX ������
# ����Ǻ��ߣ��� GNU make �����Լ�⵽�Ѿ����� PATH ����������
ifdef PATH
	MAKE = make
	RM = rm -f
else
	MAKE = mingw32-make
	RM = del
endif

all: img doc

.PHONY: img
img:
	cd img && $(MAKE)

doc: img
	$(LATEX) $(JOBNAME)
	$(BIBTEX) $(JOBNAME)
	$(LATEX) $(JOBNAME)
	$(LATEX) $(JOBNAME)
	$(DODVIPDF)

.PHONY: clean dist-clean
clean:
	$(RM) $(JOBNAME).log $(JOBNAME).aux $(JOBNAME).out  $(JOBNAME).thm\
		$(JOBNAME).toc $(JOBNAME).lof $(JOBNAME).lot $(JOBNAME).blg\
		$(JOBNAME).bbl $(JOBNAME).dvi missfont.log
	$(RM) chap/*.aux

dist-clean: clean
	$(RM) $(JOBNAME).pdf
	cd img && $(MAKE) clean

