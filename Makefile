include $(TOPDIR)/rules.mk
include $(INCLUDE_DIR)/kernel.mk

PKG_NAME:=mt7615
PKG_VERSION:=4.4.2.1
PKG_RELEASE:=1

PKG_KCONFIG:= RALINK_MT7621 WIFI_DRIVER FIRST_IF_NONE FIRST_IF_MT7615E \
	SECOND_IF_NONE SECOND_IF_MT7615E THIRD_IF_NONE THIRD_IF_MT7615E RT_FIRST_CARD \
	RT_SECOND_CARD RT_THIRD_CARD RT_FIRST_IF_RF_OFFSET RT_SECOND_IF_RF_OFFSET RT_THIRD_IF_RF_OFFSET \
	WIFI_SKB_ALLOC_SELECT WIFI_SLAB_ALLOC_SKB WIFI_PAGE_ALLOC_SKB RTDEV MT_WIFI \
	FIRST_IF_EEPROM_FLASH FIRST_IF_EEPROM_EFUSE RT_FIRST_CARD_EEPROM SECOND_IF_EEPROM_FLASH SECOND_IF_EEPROM_PROM \
	SECOND_IF_EEPROM_EFUSE RT_SECOND_CARD_EEPROM THIRD_IF_EEPROM_FLASH THIRD_IF_EEPROM_PROM THIRD_IF_EEPROM_EFUSE \
	RT_THIRD_CARD_EEPROM MULTI_INF_SUPPORT WIFI_BASIC_FUNC DOT11_N_SUPPORT DOT11_VHT_AC \
	G_BAND_256QAM_SUPPORT TPC_SUPPORT ICAP_SUPPORT BACKGROUND_SCAN_SUPPORT SMART_CARRIER_SENSE_SUPPORT \
	MT_DFS_SUPPORT HDR_TRANS_TX_SUPPORT HDR_TRANS_RX_SUPPORT DBDC_MODE MULTI_PROFILE_SUPPORT \
	DEFAULT_5G_PROFILE WSC_INCLUDED WSC_V2_SUPPORT DOT11W_PMF_SUPPORT TXBF_SUPPORT \
	IGMP_SNOOP_SUPPORT RTMP_FLASH_SUPPORT RLM_CAL_CACHE_SUPPORT PRE_CAL_TRX_SET2_SUPPORT RF_LOCKDOWN_SUPPORT \
	ATE_SUPPORT PASSPOINT_R2 UAPSD RED_SUPPORT FDB_SUPPORT \
	FIRST_IF_EPAELNA FIRST_IF_IPAILNA FIRST_IF_IPAELNA SECOND_IF_EPAELNA SECOND_IF_IPAILNA \
	SECOND_IF_IPAELNA THIRD_IF_EPAELNA THIRD_IF_IPAILNA THIRD_IF_IPAELNA RLT_MAC \
	RLT_BBP RLT_RF RTMP_MAC RTMP_BBP RTMP_RF \
	RTMP_PCI_SUPPORT RTMP_USB_SUPPORT RTMP_RBUS_SUPPORT WIFI_MODE_AP WIFI_MODE_STA \
	WIFI_MODE_BOTH MT_AP_SUPPORT WDS_SUPPORT MBSS_SUPPORT APCLI_SUPPORT \
	APCLI_CERT_SUPPORT MAC_REPEATER_SUPPORT MWDS MUMIMO_SUPPORT MU_RA_SUPPORT \
	DOT11R_FT_SUPPORT DOT11K_RRM_SUPPORT CFG80211_SUPPORT CUSTOMIZED_HOSTAPD DSCP_QOS_MAP_SUPPORT \
	CON_WPS_SUPPORT MCAST_RATE_SPECIFIC VOW_SUPPORT BAND_STEERING RADIO_LINK_SELECTION \
	LED_CONTROL_SUPPORT GPIO_CONTROL_SUPPORT RADIUS_ACCOUNTING_SUPPORT GREENAP_SUPPORT ROAMING_ENHANCE_SUPPORT \
	EASY_SETUP_SUPPORT EASY_MODULE_SUPPORT EVENT_NOTIFIER_SUPPORT AIR_MONITOR WNM_SUPPORT \
	STA_FORCE_ROAM_SUPPORT LINUX_NET_TXQ_SUPPORT RLT_MAC RTMP_MAC WIFI_MT_MAC \
	MT_MAC CHIP_MT7615E 

include $(INCLUDE_DIR)/package.mk

define KernelPackage/mt7615
  CATEGORY:=Ralink
  TITLE:=Ralink MT7615 AP driver
  FILES:=$(PKG_BUILD_DIR)/mt_wifi_ap/mt7615.ko
  AUTOLOAD:=$(call AutoLoad,91,mt7615)
  MENU:=1
endef

define KernelPackage/mt7615/config
	source "$(SOURCE)/Config-mt7615.in"
endef

define Build/Compile
	$(MAKE) -C "$(LINUX_DIR)" \
		$(KERNEL_MAKE_FLAGS) \
		SUBDIRS="$(PKG_BUILD_DIR)/mt_wifi_ap" \
		$(foreach c, $(PKG_KCONFIG),$(if $(CONFIG_$c),CONFIG_$(c)=$(CONFIG_$c)))\
		modules
endef

define KernelPackage/mt7615/install
	$(INSTALL_DIR) $(1)/lib/wifi
	$(INSTALL_DIR) $(1)/lib/firmware
	$(INSTALL_DIR) $(1)/etc_ro/Wireless/
endef

$(eval $(call KernelPackage,mt7615))