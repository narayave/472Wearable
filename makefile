TARGET=finalReport
HTML=main_html

default: pdf

both: pdf html

dvi: ${TARGET}.tex
#       pygmentize -f latex -o __${SRC}.tex ${SRC}                                                                                    
#       run latex twice to get references correct                                                                                     
	latex ${TARGET}.tex
	bibtex $(TARGET)
	latex $(TARGET).tex
	pdflatex $(TARGET).tex
#       rm __${SRC}.tex                                                                                                                
ps: dvi
	dvips -R -Poutline -t letter ${TARGET}.dvi -o ${TARGET}.ps

pdf: ps
	ps2pdf ${TARGET}.ps

html:
	cp ${TARGET}.tex ${HTML}.tex
	latex ${HTML}.tex
	latex2html -split 0 -noshow_section_numbers -local_icons -no_navigation -noinfo -noaddress ${HTML}

	sed 's/<BR><HR>//g' < ${HTML}/index.html > ${HTML}/index2.html
	mv ${HTML}/index2.html ${TARGET}.html
	rm ${HTML}.*
	rm -rf ${HTML}
