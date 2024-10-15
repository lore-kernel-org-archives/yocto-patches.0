Return-Path: <ben.cownley@arm.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57FB5D216B9
	for <webhook@archiver.kernel.org>; Tue, 15 Oct 2024 14:38:36 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mx.groups.io with SMTP id smtpd.web10.15248.1729003110897822901
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 15 Oct 2024 07:38:31 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: arm.com, ip: 217.140.110.172, mailfrom: ben.cownley@arm.com)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EDC90FEC;
	Tue, 15 Oct 2024 07:38:59 -0700 (PDT)
Received: from e125927.manchester.arm.com (e125927.arm.com [10.32.102.160])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E36F73F71E;
	Tue, 15 Oct 2024 07:38:28 -0700 (PDT)
From: Ben <Ben.Cownley@arm.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Ben Cownley <ben.cownley@arm.com>
Subject: [PATCH scarthgap 1/3] arm-systemready/linux-distros: Implement unattended openSUSE
Date: Tue, 15 Oct 2024 15:38:15 +0100
Message-Id: <20241015143817.64520-1-Ben.Cownley@arm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 15 Oct 2024 14:38:36 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/708

Implement unattended installation for openSUSE

Signed-off-by: Ben Cownley <ben.cownley@arm.com>
---
 .../arm-systemready-linux-distros-opensuse.bb |  13 +
 .../openSUSE/autoinst.xml                     | 935 ++++++++++++++++++
 2 files changed, 948 insertions(+)
 create mode 100755 meta-arm-systemready/recipes-test/arm-systemready-lin=
ux-distros/unattended-boot-conf/openSUSE/autoinst.xml

diff --git a/meta-arm-systemready/recipes-test/arm-systemready-linux-dist=
ros/arm-systemready-linux-distros-opensuse.bb b/meta-arm-systemready/reci=
pes-test/arm-systemready-linux-distros/arm-systemready-linux-distros-open=
suse.bb
index 06135d15..7d02a258 100644
--- a/meta-arm-systemready/recipes-test/arm-systemready-linux-distros/arm=
-systemready-linux-distros-opensuse.bb
+++ b/meta-arm-systemready/recipes-test/arm-systemready-linux-distros/arm=
-systemready-linux-distros-opensuse.bb
@@ -72,3 +72,16 @@ ISO_TYPE =3D "DVD"
 BUILD_NO =3D "491.1"
 SRC_URI =3D "https://download.opensuse.org/distribution/leap/${PV}/iso/o=
penSUSE-Leap-${PV}-${ISO_TYPE}-aarch64-Build${BUILD_NO}-Media.iso;unpack=3D=
0;downloadfilename=3D${ISO_IMAGE_NAME}.iso"
 SRC_URI[sha256sum] =3D "456cc4f99b044429d8a89bd302c06e9e382d6ac4dc590139=
a7096ebb54f5357b"
+
+ISO_LABEL =3D "${@oe.utils.vartrue("DISTRO_UNATTENDED_INST_TESTS", "OEMD=
RV", "", d)}"
+BOOT_CATALOG =3D "${@oe.utils.vartrue("DISTRO_UNATTENDED_INST_TESTS", "b=
oot.catalog", "", d)}"
+BOOT_IMAGE =3D "${@oe.utils.vartrue("DISTRO_UNATTENDED_INST_TESTS", "EFI=
/BOOT/bootaa64.efi", "", d)}"
+EFI_IMAGE =3D "${@oe.utils.vartrue("DISTRO_UNATTENDED_INST_TESTS", "boot=
/aarch64/efi", "", d)}"
+
+modifyiso() {
+    UNATTENDED_CONF_DIR=3D"${THISDIR}/unattended-boot-conf/openSUSE"
+
+    #create installation configuration files, remove grub timeout, setup=
 network
+    cp "${UNATTENDED_CONF_DIR}/autoinst.xml" ${EXTRACTED_ISO_TEMP_DIR}
+    sed -i 's/timeout=3D60/timeout=3D0/g' "${EXTRACTED_ISO_TEMP_DIR}/EFI=
/BOOT/grub.cfg"
+}
\ No newline at end of file
diff --git a/meta-arm-systemready/recipes-test/arm-systemready-linux-dist=
ros/unattended-boot-conf/openSUSE/autoinst.xml b/meta-arm-systemready/rec=
ipes-test/arm-systemready-linux-distros/unattended-boot-conf/openSUSE/aut=
oinst.xml
new file mode 100755
index 00000000..8da6e1cb
--- /dev/null
+++ b/meta-arm-systemready/recipes-test/arm-systemready-linux-distros/una=
ttended-boot-conf/openSUSE/autoinst.xml
@@ -0,0 +1,935 @@
+<?xml version=3D"1.0"?>
+<!DOCTYPE profile>
+<profile xmlns=3D"http://www.suse.com/1.0/yast2ns" xmlns:config=3D"http:=
//www.suse.com/1.0/configns">
+  <bootloader t=3D"map">
+    <global t=3D"map">
+      <append>splash=3Dsilent preempt=3Dfull mitigations=3Dauto quiet se=
curity=3Dapparmor</append>
+      <cpu_mitigations>auto</cpu_mitigations>
+      <gfxmode>auto</gfxmode>
+      <hiddenmenu>false</hiddenmenu>
+      <os_prober>true</os_prober>
+      <secure_boot>true</secure_boot>
+      <terminal>gfxterm</terminal>
+      <timeout t=3D"integer">8</timeout>
+      <update_nvram>true</update_nvram>
+    </global>
+    <loader_type>grub2-efi</loader_type>
+  </bootloader>
+  <firewall t=3D"map">
+    <default_zone>public</default_zone>
+    <enable_firewall t=3D"boolean">true</enable_firewall>
+    <log_denied_packets>off</log_denied_packets>
+    <start_firewall t=3D"boolean">true</start_firewall>
+    <zones t=3D"list">
+      <zone t=3D"map">
+        <description>Unsolicited incoming network packets are rejected. =
Incoming packets that are related to outgoing network connections are acc=
epted. Outgoing network connections are allowed.</description>
+        <interfaces t=3D"list"/>
+        <masquerade t=3D"boolean">false</masquerade>
+        <name>block</name>
+        <ports t=3D"list"/>
+        <protocols t=3D"list"/>
+        <services t=3D"list"/>
+        <short>Block</short>
+        <target>%%REJECT%%</target>
+      </zone>
+      <zone t=3D"map">
+        <description>For computers in your demilitarized zone that are p=
ublicly-accessible with limited access to your internal network. Only sel=
ected incoming connections are accepted.</description>
+        <interfaces t=3D"list"/>
+        <masquerade t=3D"boolean">false</masquerade>
+        <name>dmz</name>
+        <ports t=3D"list"/>
+        <protocols t=3D"list"/>
+        <services t=3D"list">
+          <service>ssh</service>
+        </services>
+        <short>DMZ</short>
+        <target>default</target>
+      </zone>
+      <zone t=3D"map">
+        <description>All network connections are accepted.</description>
+        <interfaces t=3D"list">
+          <interface>docker0</interface>
+        </interfaces>
+        <masquerade t=3D"boolean">false</masquerade>
+        <name>docker</name>
+        <ports t=3D"list"/>
+        <protocols t=3D"list"/>
+        <services t=3D"list"/>
+        <short>docker</short>
+        <target>ACCEPT</target>
+      </zone>
+      <zone t=3D"map">
+        <description>Unsolicited incoming network packets are dropped. I=
ncoming packets that are related to outgoing network connections are acce=
pted. Outgoing network connections are allowed.</description>
+        <interfaces t=3D"list"/>
+        <masquerade t=3D"boolean">false</masquerade>
+        <name>drop</name>
+        <ports t=3D"list"/>
+        <protocols t=3D"list"/>
+        <services t=3D"list"/>
+        <short>Drop</short>
+        <target>DROP</target>
+      </zone>
+      <zone t=3D"map">
+        <description>For use on external networks. You do not trust the =
other computers on networks to not harm your computer. Only selected inco=
ming connections are accepted.</description>
+        <interfaces t=3D"list"/>
+        <masquerade t=3D"boolean">true</masquerade>
+        <name>external</name>
+        <ports t=3D"list"/>
+        <protocols t=3D"list"/>
+        <services t=3D"list">
+          <service>ssh</service>
+        </services>
+        <short>External</short>
+        <target>default</target>
+      </zone>
+      <zone t=3D"map">
+        <description>For use in home areas. You mostly trust the other c=
omputers on networks to not harm your computer. Only selected incoming co=
nnections are accepted.</description>
+        <interfaces t=3D"list"/>
+        <masquerade t=3D"boolean">false</masquerade>
+        <name>home</name>
+        <ports t=3D"list"/>
+        <protocols t=3D"list"/>
+        <services t=3D"list">
+          <service>dhcpv6-client</service>
+          <service>mdns</service>
+          <service>samba-client</service>
+          <service>ssh</service>
+        </services>
+        <short>Home</short>
+        <target>default</target>
+      </zone>
+      <zone t=3D"map">
+        <description>For use on internal networks. You mostly trust the =
other computers on the networks to not harm your computer. Only selected =
incoming connections are accepted.</description>
+        <interfaces t=3D"list"/>
+        <masquerade t=3D"boolean">false</masquerade>
+        <name>internal</name>
+        <ports t=3D"list"/>
+        <protocols t=3D"list"/>
+        <services t=3D"list">
+          <service>dhcpv6-client</service>
+          <service>mdns</service>
+          <service>samba-client</service>
+          <service>ssh</service>
+        </services>
+        <short>Internal</short>
+        <target>default</target>
+      </zone>
+      <zone t=3D"map">
+        <description>For use in public areas. You do not trust the other=
 computers on networks to not harm your computer. Only selected incoming =
connections are accepted.</description>
+        <interfaces t=3D"list">
+          <interface>eth0</interface>
+        </interfaces>
+        <masquerade t=3D"boolean">false</masquerade>
+        <name>public</name>
+        <ports t=3D"list"/>
+        <protocols t=3D"list"/>
+        <services t=3D"list">
+          <service>dhcpv6-client</service>
+          <service>ssh</service>
+        </services>
+        <short>Public</short>
+        <target>default</target>
+      </zone>
+      <zone t=3D"map">
+        <description>All network connections are accepted.</description>
+        <interfaces t=3D"list"/>
+        <masquerade t=3D"boolean">false</masquerade>
+        <name>trusted</name>
+        <ports t=3D"list"/>
+        <protocols t=3D"list"/>
+        <services t=3D"list"/>
+        <short>Trusted</short>
+        <target>ACCEPT</target>
+      </zone>
+      <zone t=3D"map">
+        <description>For use in work areas. You mostly trust the other c=
omputers on networks to not harm your computer. Only selected incoming co=
nnections are accepted.</description>
+        <interfaces t=3D"list"/>
+        <masquerade t=3D"boolean">false</masquerade>
+        <name>work</name>
+        <ports t=3D"list"/>
+        <protocols t=3D"list"/>
+        <services t=3D"list">
+          <service>dhcpv6-client</service>
+          <service>ssh</service>
+        </services>
+        <short>Work</short>
+        <target>default</target>
+      </zone>
+    </zones>
+  </firewall>
+  <general t=3D"map">
+    <mode t=3D"map">
+      <confirm t=3D"boolean">false</confirm>
+    </mode>
+  </general>
+  <groups t=3D"list">
+    <group t=3D"map">
+      <gid>100</gid>
+      <groupname>users</groupname>
+      <userlist/>
+    </group>
+    <group t=3D"map">
+      <gid>499</gid>
+      <groupname>messagebus</groupname>
+      <userlist/>
+    </group>
+    <group t=3D"map">
+      <gid>1</gid>
+      <groupname>bin</groupname>
+      <userlist>daemon</userlist>
+    </group>
+    <group t=3D"map">
+      <gid>488</gid>
+      <groupname>input</groupname>
+      <userlist/>
+    </group>
+    <group t=3D"map">
+      <gid>495</gid>
+      <groupname>kmem</groupname>
+      <userlist/>
+    </group>
+    <group t=3D"map">
+      <gid>493</gid>
+      <groupname>utmp</groupname>
+      <userlist/>
+    </group>
+    <group t=3D"map">
+      <gid>62</gid>
+      <groupname>man</groupname>
+      <userlist/>
+    </group>
+    <group t=3D"map">
+      <gid>477</gid>
+      <groupname>polkitd</groupname>
+      <userlist/>
+    </group>
+    <group t=3D"map">
+      <gid>479</gid>
+      <groupname>systemd-timesync</groupname>
+      <userlist/>
+    </group>
+    <group t=3D"map">
+      <gid>2</gid>
+      <groupname>daemon</groupname>
+      <userlist/>
+    </group>
+    <group t=3D"map">
+      <gid>480</gid>
+      <groupname>systemd-network</groupname>
+      <userlist/>
+    </group>
+    <group t=3D"map">
+      <gid>71</gid>
+      <groupname>ntadmin</groupname>
+      <userlist/>
+    </group>
+    <group t=3D"map">
+      <gid>490</gid>
+      <groupname>dialout</groupname>
+      <userlist/>
+    </group>
+    <group t=3D"map">
+      <gid>59</gid>
+      <groupname>maildrop</groupname>
+      <userlist>postfix</userlist>
+    </group>
+    <group t=3D"map">
+      <gid>478</gid>
+      <groupname>nscd</groupname>
+      <userlist/>
+    </group>
+    <group t=3D"map">
+      <gid>51</gid>
+      <groupname>postfix</groupname>
+      <userlist/>
+    </group>
+    <group t=3D"map">
+      <gid>485</gid>
+      <groupname>tape</groupname>
+      <userlist/>
+    </group>
+    <group t=3D"map">
+      <gid>487</gid>
+      <groupname>render</groupname>
+      <userlist/>
+    </group>
+    <group t=3D"map">
+      <gid>476</gid>
+      <groupname>sshd</groupname>
+      <userlist/>
+    </group>
+    <group t=3D"map">
+      <gid>491</gid>
+      <groupname>cdrom</groupname>
+      <userlist/>
+    </group>
+    <group t=3D"map">
+      <gid>486</gid>
+      <groupname>sgx</groupname>
+      <userlist/>
+    </group>
+    <group t=3D"map">
+      <gid>0</gid>
+      <groupname>root</groupname>
+      <userlist/>
+    </group>
+    <group t=3D"map">
+      <gid>489</gid>
+      <groupname>disk</groupname>
+      <userlist/>
+    </group>
+    <group t=3D"map">
+      <gid>15</gid>
+      <groupname>shadow</groupname>
+      <userlist/>
+    </group>
+    <group t=3D"map">
+      <gid>484</gid>
+      <groupname>video</groupname>
+      <userlist/>
+    </group>
+    <group t=3D"map">
+      <gid>496</gid>
+      <groupname>wheel</groupname>
+      <userlist/>
+    </group>
+    <group t=3D"map">
+      <gid>483</gid>
+      <groupname>audit</groupname>
+      <userlist/>
+    </group>
+    <group t=3D"map">
+      <gid>498</gid>
+      <groupname>mail</groupname>
+      <userlist>postfix</userlist>
+    </group>
+    <group t=3D"map">
+      <gid>5</gid>
+      <groupname>tty</groupname>
+      <userlist/>
+    </group>
+    <group t=3D"map">
+      <gid>65533</gid>
+      <groupname>nogroup</groupname>
+      <userlist/>
+    </group>
+    <group t=3D"map">
+      <gid>65534</gid>
+      <groupname>nobody</groupname>
+      <userlist/>
+    </group>
+    <group t=3D"map">
+      <gid>497</gid>
+      <groupname>lp</groupname>
+      <userlist/>
+    </group>
+    <group t=3D"map">
+      <gid>482</gid>
+      <groupname>chrony</groupname>
+      <userlist/>
+    </group>
+    <group t=3D"map">
+      <gid>492</gid>
+      <groupname>audio</groupname>
+      <userlist/>
+    </group>
+    <group t=3D"map">
+      <gid>494</gid>
+      <groupname>lock</groupname>
+      <userlist/>
+    </group>
+    <group t=3D"map">
+      <gid>36</gid>
+      <groupname>kvm</groupname>
+      <userlist/>
+    </group>
+    <group t=3D"map">
+      <gid>42</gid>
+      <groupname>trusted</groupname>
+      <userlist/>
+    </group>
+    <group t=3D"map">
+      <gid>481</gid>
+      <groupname>systemd-journal</groupname>
+      <userlist/>
+    </group>
+  </groups>
+  <host t=3D"map">
+    <hosts t=3D"list">
+      <hosts_entry t=3D"map">
+        <host_address>127.0.0.1</host_address>
+        <names t=3D"list">
+          <name>localhost</name>
+        </names>
+      </hosts_entry>
+      <hosts_entry t=3D"map">
+        <host_address>::1</host_address>
+        <names t=3D"list">
+          <name>localhost ipv6-localhost ipv6-loopback</name>
+        </names>
+      </hosts_entry>
+      <hosts_entry t=3D"map">
+        <host_address>fe00::0</host_address>
+        <names t=3D"list">
+          <name>ipv6-localnet</name>
+        </names>
+      </hosts_entry>
+      <hosts_entry t=3D"map">
+        <host_address>ff00::0</host_address>
+        <names t=3D"list">
+          <name>ipv6-mcastprefix</name>
+        </names>
+      </hosts_entry>
+      <hosts_entry t=3D"map">
+        <host_address>ff02::1</host_address>
+        <names t=3D"list">
+          <name>ipv6-allnodes</name>
+        </names>
+      </hosts_entry>
+      <hosts_entry t=3D"map">
+        <host_address>ff02::2</host_address>
+        <names t=3D"list">
+          <name>ipv6-allrouters</name>
+        </names>
+      </hosts_entry>
+      <hosts_entry t=3D"map">
+        <host_address>ff02::3</host_address>
+        <names t=3D"list">
+          <name>ipv6-allhosts</name>
+        </names>
+      </hosts_entry>
+    </hosts>
+  </host>
+  <language t=3D"map">
+    <language>en_GB</language>
+    <languages>en_GB</languages>
+  </language>
+  <networking t=3D"map">
+    <dhcp_options t=3D"map">
+      <dhclient_client_id/>
+      <dhclient_hostname_option>AUTO</dhclient_hostname_option>
+    </dhcp_options>
+    <dns t=3D"map">
+      <dhcp_hostname t=3D"boolean">true</dhcp_hostname>
+      <hostname>localhost</hostname>
+      <resolv_conf_policy>auto</resolv_conf_policy>
+    </dns>
+    <interfaces t=3D"list">
+      <interface t=3D"map">
+        <bootproto>dhcp</bootproto>
+        <name>eth0</name>
+        <startmode>auto</startmode>
+        <zone>public</zone>
+      </interface>
+    </interfaces>
+    <ipv6 t=3D"boolean">true</ipv6>
+    <keep_install_network t=3D"boolean">true</keep_install_network>
+    <managed t=3D"boolean">false</managed>
+    <routing t=3D"map">
+      <ipv4_forward t=3D"boolean">false</ipv4_forward>
+      <ipv6_forward t=3D"boolean">false</ipv6_forward>
+    </routing>
+  </networking>
+  <ntp-client t=3D"map">
+    <ntp_policy>auto</ntp_policy>
+    <ntp_servers t=3D"list"/>
+    <ntp_sync>systemd</ntp_sync>
+  </ntp-client>
+  <partitioning t=3D"list">
+    <drive t=3D"map">
+      <device>/dev/vda</device>
+      <disklabel>gpt</disklabel>
+      <enable_snapshots t=3D"boolean">false</enable_snapshots>
+      <partitions t=3D"list">
+        <partition t=3D"map">
+          <create t=3D"boolean">true</create>
+          <filesystem t=3D"symbol">vfat</filesystem>
+          <format t=3D"boolean">true</format>
+          <fstopt>utf8</fstopt>
+          <mount>/boot/efi</mount>
+          <mountby t=3D"symbol">uuid</mountby>
+          <partition_id t=3D"integer">259</partition_id>
+          <partition_nr t=3D"integer">1</partition_nr>
+          <resize t=3D"boolean">false</resize>
+          <size>134217728</size>
+        </partition>
+        <partition t=3D"map">
+          <create t=3D"boolean">true</create>
+          <create_subvolumes t=3D"boolean">true</create_subvolumes>
+          <filesystem t=3D"symbol">btrfs</filesystem>
+          <format t=3D"boolean">true</format>
+          <mount>/</mount>
+          <mountby t=3D"symbol">uuid</mountby>
+          <partition_id t=3D"integer">131</partition_id>
+          <partition_nr t=3D"integer">2</partition_nr>
+          <quotas t=3D"boolean">false</quotas>
+          <resize t=3D"boolean">false</resize>
+          <size>6307167744</size>
+          <subvolumes t=3D"list">
+            <subvolume t=3D"map">
+              <copy_on_write t=3D"boolean">false</copy_on_write>
+              <path>var</path>
+            </subvolume>
+            <subvolume t=3D"map">
+              <copy_on_write t=3D"boolean">true</copy_on_write>
+              <path>usr/local</path>
+            </subvolume>
+            <subvolume t=3D"map">
+              <copy_on_write t=3D"boolean">true</copy_on_write>
+              <path>tmp</path>
+            </subvolume>
+            <subvolume t=3D"map">
+              <copy_on_write t=3D"boolean">true</copy_on_write>
+              <path>srv</path>
+            </subvolume>
+            <subvolume t=3D"map">
+              <copy_on_write t=3D"boolean">true</copy_on_write>
+              <path>root</path>
+            </subvolume>
+            <subvolume t=3D"map">
+              <copy_on_write t=3D"boolean">true</copy_on_write>
+              <path>opt</path>
+            </subvolume>
+            <subvolume t=3D"map">
+              <copy_on_write t=3D"boolean">true</copy_on_write>
+              <path>home</path>
+            </subvolume>
+            <subvolume t=3D"map">
+              <copy_on_write t=3D"boolean">true</copy_on_write>
+              <path>boot/grub2/arm64-efi</path>
+            </subvolume>
+          </subvolumes>
+          <subvolumes_prefix>@</subvolumes_prefix>
+        </partition>
+      </partitions>
+      <type t=3D"symbol">CT_DISK</type>
+      <use>all</use>
+    </drive>
+  </partitioning>
+  <proxy t=3D"map">
+    <enabled t=3D"boolean">false</enabled>
+  </proxy>
+  <services-manager t=3D"map">
+    <default_target>multi-user</default_target>
+    <services t=3D"map">
+      <enable t=3D"list">
+        <service>YaST2-Firstboot</service>
+        <service>YaST2-Second-Stage</service>
+        <service>apparmor</service>
+        <service>auditd</service>
+        <service>klog</service>
+        <service>chronyd</service>
+        <service>cron</service>
+        <service>cups</service>
+        <service>firewalld</service>
+        <service>wickedd-auto4</service>
+        <service>wickedd-dhcp4</service>
+        <service>wickedd-dhcp6</service>
+        <service>wickedd-nanny</service>
+        <service>irqbalance</service>
+        <service>issue-generator</service>
+        <service>kbdsettings</service>
+        <service>wicked</service>
+        <service>nscd</service>
+        <service>postfix</service>
+        <service>purge-kernels</service>
+        <service>rsyslog</service>
+        <service>smartd</service>
+        <service>sshd</service>
+        <service>systemd-pstore</service>
+        <service>systemd-remount-fs</service>
+      </enable>
+    </services>
+  </services-manager>
+  <software t=3D"map">
+    <install_recommended t=3D"boolean">true</install_recommended>
+    <instsource/>
+    <packages t=3D"list">
+      <package>wicked</package>
+      <package>shim</package>
+      <package>os-prober</package>
+      <package>openssh</package>
+      <package>openSUSE-release</package>
+      <package>mokutil</package>
+      <package>kexec-tools</package>
+      <package>grub2-arm64-efi</package>
+      <package>glibc</package>
+      <package>firewalld</package>
+      <package>e2fsprogs</package>
+      <package>dosfstools</package>
+      <package>chrony</package>
+      <package>btrfsprogs</package>
+      <package>autoyast2</package>
+    </packages>
+    <patterns t=3D"list">
+      <pattern>apparmor</pattern>
+      <pattern>base</pattern>
+      <pattern>documentation</pattern>
+      <pattern>enhanced_base</pattern>
+      <pattern>minimal_base</pattern>
+      <pattern>sw_management</pattern>
+      <pattern>yast2_basis</pattern>
+    </patterns>
+    <products t=3D"list">
+      <product>Leap</product>
+    </products>
+  </software>
+  <ssh_import t=3D"map">
+    <copy_config t=3D"boolean">false</copy_config>
+    <import t=3D"boolean">false</import>
+  </ssh_import>
+  <user_defaults t=3D"map">
+    <expire/>
+    <group>100</group>
+    <home>/home</home>
+    <inactive>-1</inactive>
+    <shell>/bin/bash</shell>
+    <umask>022</umask>
+  </user_defaults>
+  <users t=3D"list">
+    <user t=3D"map">
+      <authorized_keys t=3D"list"/>
+      <encrypted t=3D"boolean">true</encrypted>
+      <fullname>user</fullname>
+      <gid>100</gid>
+      <home>/home/user</home>
+      <home_btrfs_subvolume t=3D"boolean">false</home_btrfs_subvolume>
+      <password_settings t=3D"map">
+        <expire/>
+        <flag/>
+        <inact/>
+        <max>99999</max>
+        <min>0</min>
+        <warn>7</warn>
+      </password_settings>
+      <shell>/bin/bash</shell>
+      <uid>1000</uid>
+      <user_password>$6$WV8CB/c6j0zhAi5S$4euhbt4alH7WNfaatS9IJgPiiKDJ48d=
5Ru1zCZCA0N9GiyOPuefN2PAUWlyYeTgqAInpyvPh1frdp4fFVjvEn0</user_password>
+      <username>user</username>
+    </user>
+    <user t=3D"map">
+      <encrypted t=3D"boolean">true</encrypted>
+      <fullname>User for nscd</fullname>
+      <gid>478</gid>
+      <home>/run/nscd</home>
+      <home_btrfs_subvolume t=3D"boolean">false</home_btrfs_subvolume>
+      <password_settings t=3D"map">
+        <expire/>
+        <flag/>
+        <inact/>
+        <max/>
+        <min/>
+        <warn/>
+      </password_settings>
+      <shell>/sbin/nologin</shell>
+      <uid>478</uid>
+      <user_password>!</user_password>
+      <username>nscd</username>
+    </user>
+    <user t=3D"map">
+      <encrypted t=3D"boolean">true</encrypted>
+      <fullname>systemd Network Management</fullname>
+      <gid>480</gid>
+      <home>/</home>
+      <home_btrfs_subvolume t=3D"boolean">false</home_btrfs_subvolume>
+      <password_settings t=3D"map">
+        <expire/>
+        <flag/>
+        <inact/>
+        <max/>
+        <min/>
+        <warn/>
+      </password_settings>
+      <shell>/usr/sbin/nologin</shell>
+      <uid>480</uid>
+      <user_password>!*</user_password>
+      <username>systemd-network</username>
+    </user>
+    <user t=3D"map">
+      <encrypted t=3D"boolean">true</encrypted>
+      <fullname>Daemon</fullname>
+      <gid>2</gid>
+      <home>/sbin</home>
+      <home_btrfs_subvolume t=3D"boolean">false</home_btrfs_subvolume>
+      <password_settings t=3D"map">
+        <expire/>
+        <flag/>
+        <inact/>
+        <max/>
+        <min/>
+        <warn/>
+      </password_settings>
+      <shell>/usr/sbin/nologin</shell>
+      <uid>2</uid>
+      <user_password>!</user_password>
+      <username>daemon</username>
+    </user>
+    <user t=3D"map">
+      <encrypted t=3D"boolean">true</encrypted>
+      <fullname>systemd Time Synchronization</fullname>
+      <gid>479</gid>
+      <home>/</home>
+      <home_btrfs_subvolume t=3D"boolean">false</home_btrfs_subvolume>
+      <password_settings t=3D"map">
+        <expire/>
+        <flag/>
+        <inact/>
+        <max/>
+        <min/>
+        <warn/>
+      </password_settings>
+      <shell>/usr/sbin/nologin</shell>
+      <uid>479</uid>
+      <user_password>!*</user_password>
+      <username>systemd-timesync</username>
+    </user>
+    <user t=3D"map">
+      <encrypted t=3D"boolean">true</encrypted>
+      <fullname>user for rpcbind</fullname>
+      <gid>65534</gid>
+      <home>/var/lib/empty</home>
+      <home_btrfs_subvolume t=3D"boolean">false</home_btrfs_subvolume>
+      <password_settings t=3D"map">
+        <expire/>
+        <flag/>
+        <inact/>
+        <max/>
+        <min/>
+        <warn/>
+      </password_settings>
+      <shell>/sbin/nologin</shell>
+      <uid>475</uid>
+      <user_password>!</user_password>
+      <username>rpc</username>
+    </user>
+    <user t=3D"map">
+      <encrypted t=3D"boolean">true</encrypted>
+      <fullname>SSH daemon</fullname>
+      <gid>476</gid>
+      <home>/var/lib/sshd</home>
+      <home_btrfs_subvolume t=3D"boolean">false</home_btrfs_subvolume>
+      <password_settings t=3D"map">
+        <expire/>
+        <flag/>
+        <inact/>
+        <max/>
+        <min/>
+        <warn/>
+      </password_settings>
+      <shell>/usr/sbin/nologin</shell>
+      <uid>476</uid>
+      <user_password>!</user_password>
+      <username>sshd</username>
+    </user>
+    <user t=3D"map">
+      <encrypted t=3D"boolean">true</encrypted>
+      <fullname>Postfix Daemon</fullname>
+      <gid>51</gid>
+      <home>/var/spool/postfix</home>
+      <home_btrfs_subvolume t=3D"boolean">false</home_btrfs_subvolume>
+      <password_settings t=3D"map">
+        <expire/>
+        <flag/>
+        <inact/>
+        <max/>
+        <min/>
+        <warn/>
+      </password_settings>
+      <shell>/usr/sbin/nologin</shell>
+      <uid>51</uid>
+      <user_password>!</user_password>
+      <username>postfix</username>
+    </user>
+    <user t=3D"map">
+      <encrypted t=3D"boolean">true</encrypted>
+      <fullname>NFS statd daemon</fullname>
+      <gid>65533</gid>
+      <home>/var/lib/nfs</home>
+      <home_btrfs_subvolume t=3D"boolean">false</home_btrfs_subvolume>
+      <password_settings t=3D"map">
+        <expire/>
+        <flag/>
+        <inact/>
+        <max/>
+        <min/>
+        <warn/>
+      </password_settings>
+      <shell>/sbin/nologin</shell>
+      <uid>474</uid>
+      <user_password>!</user_password>
+      <username>statd</username>
+    </user>
+    <user t=3D"map">
+      <encrypted t=3D"boolean">true</encrypted>
+      <fullname>bin</fullname>
+      <gid>1</gid>
+      <home>/bin</home>
+      <home_btrfs_subvolume t=3D"boolean">false</home_btrfs_subvolume>
+      <password_settings t=3D"map">
+        <expire/>
+        <flag/>
+        <inact/>
+        <max/>
+        <min/>
+        <warn/>
+      </password_settings>
+      <shell>/usr/sbin/nologin</shell>
+      <uid>1</uid>
+      <user_password>!</user_password>
+      <username>bin</username>
+    </user>
+    <user t=3D"map">
+      <authorized_keys t=3D"list"/>
+      <encrypted t=3D"boolean">true</encrypted>
+      <fullname>root</fullname>
+      <gid>0</gid>
+      <home>/root</home>
+      <home_btrfs_subvolume t=3D"boolean">false</home_btrfs_subvolume>
+      <password_settings t=3D"map">
+        <expire/>
+        <flag/>
+        <inact/>
+        <max/>
+        <min/>
+        <warn/>
+      </password_settings>
+      <shell>/bin/bash</shell>
+      <uid>0</uid>
+      <user_password>$6$zAe5W7gw/kja9aKy$mM.BWtNyjalXrDNig4CUfN3bgfmehUI=
s8.zvBwWn1XroK104G.rY3lyup3OH8TujieUmgO4J74Df.LktV4A1K1</user_password>
+      <username>root</username>
+    </user>
+    <user t=3D"map">
+      <encrypted t=3D"boolean">true</encrypted>
+      <fullname>User for D-Bus</fullname>
+      <gid>499</gid>
+      <home>/run/dbus</home>
+      <home_btrfs_subvolume t=3D"boolean">false</home_btrfs_subvolume>
+      <password_settings t=3D"map">
+        <expire/>
+        <flag/>
+        <inact/>
+        <max/>
+        <min/>
+        <warn/>
+      </password_settings>
+      <shell>/usr/bin/false</shell>
+      <uid>499</uid>
+      <user_password>!</user_password>
+      <username>messagebus</username>
+    </user>
+    <user t=3D"map">
+      <encrypted t=3D"boolean">true</encrypted>
+      <fullname>Manual pages viewer</fullname>
+      <gid>62</gid>
+      <home>/var/lib/empty</home>
+      <home_btrfs_subvolume t=3D"boolean">false</home_btrfs_subvolume>
+      <password_settings t=3D"map">
+        <expire/>
+        <flag/>
+        <inact/>
+        <max/>
+        <min/>
+        <warn/>
+      </password_settings>
+      <shell>/usr/sbin/nologin</shell>
+      <uid>13</uid>
+      <user_password>!</user_password>
+      <username>man</username>
+    </user>
+    <user t=3D"map">
+      <encrypted t=3D"boolean">true</encrypted>
+      <fullname>Printing daemon</fullname>
+      <gid>497</gid>
+      <home>/var/spool/lpd</home>
+      <home_btrfs_subvolume t=3D"boolean">false</home_btrfs_subvolume>
+      <password_settings t=3D"map">
+        <expire/>
+        <flag/>
+        <inact/>
+        <max/>
+        <min/>
+        <warn/>
+      </password_settings>
+      <shell>/usr/sbin/nologin</shell>
+      <uid>497</uid>
+      <user_password>!</user_password>
+      <username>lp</username>
+    </user>
+    <user t=3D"map">
+      <encrypted t=3D"boolean">true</encrypted>
+      <fullname>User for polkitd</fullname>
+      <gid>477</gid>
+      <home>/var/lib/polkit</home>
+      <home_btrfs_subvolume t=3D"boolean">false</home_btrfs_subvolume>
+      <password_settings t=3D"map">
+        <expire/>
+        <flag/>
+        <inact/>
+        <max/>
+        <min/>
+        <warn/>
+      </password_settings>
+      <shell>/usr/sbin/nologin</shell>
+      <uid>477</uid>
+      <user_password>!</user_password>
+      <username>polkitd</username>
+    </user>
+    <user t=3D"map">
+      <encrypted t=3D"boolean">true</encrypted>
+      <fullname>Chrony Daemon</fullname>
+      <gid>482</gid>
+      <home>/var/lib/chrony</home>
+      <home_btrfs_subvolume t=3D"boolean">false</home_btrfs_subvolume>
+      <password_settings t=3D"map">
+        <expire/>
+        <flag/>
+        <inact/>
+        <max/>
+        <min/>
+        <warn/>
+      </password_settings>
+      <shell>/usr/sbin/nologin</shell>
+      <uid>496</uid>
+      <user_password>!</user_password>
+      <username>chrony</username>
+    </user>
+    <user t=3D"map">
+      <encrypted t=3D"boolean">true</encrypted>
+      <fullname>nobody</fullname>
+      <gid>65534</gid>
+      <home>/var/lib/nobody</home>
+      <home_btrfs_subvolume t=3D"boolean">false</home_btrfs_subvolume>
+      <password_settings t=3D"map">
+        <expire/>
+        <flag/>
+        <inact/>
+        <max/>
+        <min/>
+        <warn/>
+      </password_settings>
+      <shell>/bin/bash</shell>
+      <uid>65534</uid>
+      <user_password>!</user_password>
+      <username>nobody</username>
+    </user>
+    <user t=3D"map">
+      <encrypted t=3D"boolean">true</encrypted>
+      <fullname>Mailer daemon</fullname>
+      <gid>498</gid>
+      <home>/var/spool/clientmqueue</home>
+      <home_btrfs_subvolume t=3D"boolean">false</home_btrfs_subvolume>
+      <password_settings t=3D"map">
+        <expire/>
+        <flag/>
+        <inact/>
+        <max/>
+        <min/>
+        <warn/>
+      </password_settings>
+      <shell>/usr/sbin/nologin</shell>
+      <uid>498</uid>
+      <user_password>!</user_password>
+      <username>mail</username>
+    </user>
+  </users>
+</profile>
--=20
2.34.1


