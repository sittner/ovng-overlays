.PHONY: all clean install

DTC_FLAGS += -Wno-unit_address_vs_reg

all: bone-i2c2.dtbo ovng-baseboard.dtbo ovng-uart1.dtbo ovng-can1.dtbo ovng-lcd7-adafruit.dtbo ovng-lcd7-seeed.dtbo


%.dtspp: %.dts
	$(CPP) -nostdinc -Iinclude -I. -Itestcase-data -undef -D__DTS__ -x assembler-with-cpp -o $@ $<

%.dtbo: %.dtspp
	dtc -O dtb -o $@ -b 0 -@ $<

clean:
	rm -f *.dtspp *.dtbo

install: all
	mkdir -p $(TARGET_DIR)/boot/overlays
	cp *.dtbo $(TARGET_DIR)/boot/overlays

