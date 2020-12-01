.PHONY: all clean install

DTC_FLAGS += -Wno-unit_address_vs_reg

all: BB-OVNG-00A0.dtbo BB-OVNG-CAN1-00A0.dtbo BB-OVNG-UART1-00A0.dtbo BB-OVNG-LCD7-00A0.dtbo


%.dtspp: %.dts
	$(CPP) -nostdinc -Iinclude -I. -Itestcase-data -undef -D__DTS__ -x assembler-with-cpp -o $@ $<

%.dtbo: %.dtspp
	dtc -O dtb -o $@ -b 0 -@ $<

clean:
	rm -f *.dtspp *.dtbo

install: all
	mkdir -p $(TARGET_DIR)/lib/firmware/
	cp *.dtbo $(TARGET_DIR)/lib/firmware/

