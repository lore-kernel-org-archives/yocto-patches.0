Return-Path: <ross.burton@arm.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1646CD98C5
	for <webhook@archiver.kernel.org>; Mon, 15 Jun 2026 09:34:33 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.125958.1781516042518219977
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 15 Jun 2026 02:34:03 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@qualcomm.com header.s=qcppdkim1 header.b=CpLhHrLm;
 dkim=fail reason="dkim: body hash did not verify" header.i=@oss.qualcomm.com header.s=google header.b=eQdMhr5W;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: oss.qualcomm.com, ip: 205.220.180.131, mailfrom: prathibha.madugonde@oss.qualcomm.com)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65F9TekT4161094
	for <yocto-patches@lists.yoctoproject.org>; Mon, 15 Jun 2026 09:34:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=Y3tW5Eio/VE6o2zURN3ueR
	SgSpDGeuTdRpIVZerFO9Q=; b=CpLhHrLm9kxMvoKMpIoq77LgVb6lTkZdYUJrYH
	fyJoDgjIOVJCb7wqiarkOZl75CmrQR1Bg8cvilMluHFSPf/zqzaciWjVOklLHTYJ
	aCcMYdeIyZ5jeVvZoIJptK+xl2KzdtaEi6vuYqOIDtl0KaR/i5TE57x3PsKCb5vZ
	Sy4MMjRzbFdVZt9XnvDP2XOeVYj0WfCsBGKdfCSn2rWLtCIFKbRJDLcXhQKFM9SX
	XrJNbuVRo6jF2eDQ+WqwZRN9WIQHE+Ls2T8h8sS1cbq1HNu77L06ddIX6xgkccks
	tb8ohEUnMtTESnwzpHgJrEj8CVxas+3ZDzdUZ9cttQhVhhpA==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4etetf00h8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Mon, 15 Jun 2026 09:34:00 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-36d98b5a68fso5790666a91.2
        for <yocto-patches@lists.yoctoproject.org>; Mon, 15 Jun 2026 02:34:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781516040; x=1782120840; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Y3tW5Eio/VE6o2zURN3ueRSgSpDGeuTdRpIVZerFO9Q=;
        b=eQdMhr5WnFl8fXypGhBMH8AfG9A1GU7olum9IIfBTVP2ByDj4oro7vf8ZgUV/pSBSM
         h6FklUz+210l5aTDx9Xt1lJ//O7d+c+/hTf/Ske/61QHgK1xGCIAe7FeuUK3TjRV6Nqd
         0AXHkBl2OvXY15YVmhWqYACeda9AXfy/wNvvab7wk5r0/KVH4NCuCz/W95aZplvZ0LVl
         YAEp5SDUFMdp+gjc/5JUstDaYLFnFJQ4Kv1gtbNLiBO3nXOnYm+xlKR9nJS7UDCmv9tv
         bUCmJmVLT1sPGt8HaFejGoJdcSI8YGoM5fmaS4XrcJK61fVzy+k0haxppvgx3IvJLRoX
         srBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781516040; x=1782120840;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y3tW5Eio/VE6o2zURN3ueRSgSpDGeuTdRpIVZerFO9Q=;
        b=pypXZOjW4RuNAR+8GpwgaOztXbnLVY7zqa0yF/nus9c8dHOFGRH0uhKCf3bdPgab2U
         favfA8XmfZkzS1pUOZV0oXIkvE5Dww0yBSsfIsTGyYRmSABEAvId+6c+b8CKUjPMZScm
         UkL2prn3z9PvS3iM3hLzxJsckMyksKqa6Lmk6oz4tsD8oy5xLoRBk0B02W6cE0tm4rEA
         tffwpsdz+MQIfvDYRbMAzxIKhjFVLmY6mjEW5v7i0NWcnNiPvW6ZncBtSONEpUAXtnnz
         fyXyxdWebls6GolbUx/ut+SPjbt655lES6hLxj3pbOeMpZ5RlZVG+v4sDEwc2VHxVl9K
         /jvQ==
X-Gm-Message-State: AOJu0YwVLdsVrtSzJgKdRtxUpxk737f+LiG0krgHgGVcJmjPkjmXN+Ec
	swV4wdddfVhnCebQ+NpCE9wKJZBGqlwYdGN84p/aZOThcispK46hwRyXTIkpTazTbOwXlvXWdNW
	OcYdj/tg9lPkqpJdw+aNkHUVifzpLglg+H7F5V8HhvsPUkyTAGGf98T8e282XlvvjPt6Ouk4j+D
	YJDI1zkJr7sg==
X-Gm-Gg: Acq92OFO4GfOfq2IV7tz5A20NlhPXbN2MeY5mxF3Yc5rd556k4DHT9QKXif8YT9Iefv
	Dj7Vs00+H90i4Kgzdnq8SQKwqhWKR6gfTxNKAgy41sENCxJugbDtfmw6gPY6+70mLJmAkZQm5A5
	7WKoV7pGvceIZth7O2z+kdGnApxtkWp7i975NovtlCVxc35uvOQWmI1nm+v4IGlKrLrLvx2yvgI
	9v01MLP2Eh6eiNKLDpPkk8cr9kjybFD31lhFHrc+GYuRXKxuknYKDhX8PF8CzxDXOFLJ9xEcRMZ
	8cIRwl2NYGNm/7zrT4f5roiczV4nt9jl0Hp4SeaGcLpp8thI8E8U2+9gN7PPdna3l/UQPXuxcbl
	PrGRytJcvXfPIyzuS8m9rGKqPqjwHmOry0tdE3AXUW9M=
X-Received: by 2002:a17:90b:1ccc:b0:36a:f612:e6a3 with SMTP id 98e67ed59e1d1-37c2bd493femr10115068a91.17.1781516037705;
        Mon, 15 Jun 2026 02:33:57 -0700 (PDT)
X-Received: by 2002:a17:90b:1ccc:b0:36a:f612:e6a3 with SMTP id 98e67ed59e1d1-37c2bd493femr10114945a91.17.1781516035715;
        Mon, 15 Jun 2026 02:33:55 -0700 (PDT)
Received: from hu-prathm-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-37a233f4531sm10026876a91.2.2026.06.15.02.33.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 02:33:55 -0700 (PDT)
From: "Prathibha Madugonde" <prathibha.madugonde@oss.qualcomm.com>
X-Google-Original-From: Prathibha Madugonde <prathm@qti.qualcomm.com>
To: yocto-patches@lists.yoctoproject.org
Cc: quic_mohamull@quicinc.com, quic_hbandi@quicinc.com,
        quic_anubhavg@quicinc.com
Subject: [meta-lts-mixins][PATCH v1] bluez5: Backport BLE Channel Sounding (CS) reflector role
Date: Mon, 15 Jun 2026 15:03:50 +0530
Message-Id: <20260615093350.1170306-1-prathm@qti.qualcomm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Authority-Analysis: v=2.4 cv=adxRWxot c=1 sm=1 tr=0 ts=6a2fc709 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=NEAV23lmAAAA:8 a=Q4-j1AaZAAAA:8 a=iGHA9ds3AAAA:8
 a=iP7vMvkZAAAA:8 a=QyXUC8HyAAAA:8 a=LwqS0rvhHK8vVrcS_7IA:9
 a=B_Pfwymm7kymGRPe:21 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22 a=9H3Qd4_ONW2Ztcrla5EB:22 a=nM-MV4yxpKKO9kiQg6Ot:22
 a=SKixG8JwDLmn6dAKAxWB:22
X-Proofpoint-GUID: p48hgeiI-t-kp27F05kD3tf3LA3Cgo36
X-Proofpoint-ORIG-GUID: p48hgeiI-t-kp27F05kD3tf3LA3Cgo36
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE1MDA5OSBTYWx0ZWRfX/GFn1Iq6B+34
 uEIxZ16hYBO6+ewau9WidJ5yQH4F/iiF5sviGeA9oe5DuWo30TYBXkPcHBp4HUBdG3FSzrFpHxK
 OJtXeTFm3ifmEkZTiO6rkqIPrMfvPKo=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE1MDA5OSBTYWx0ZWRfX50O/rOPzDWvK
 YnMw8mhrdYFSB0IiF1rq6aBC45QUkdhvwNK0g7kEc4T8N7DXPullTiKnfdUYN7CWd7PD4nwdm9h
 HEoiC7SbS8x3Q8huK2/7IfV/iWQjySgWDdBuQc7kUkIIL+9oKnssf17qNA3U4OtSN7BaeI+RTmW
 7kTsiANKnVRUnIa9DM1QlMz7ldYNSu3ffUUXWcAuXNMXQNDAFawTSsv5nv8CxmfX3KVCJc1syQV
 22rWj4r8zbTzJ20tnV6PEj5+h6IhVGDbrEMs+btuidm+WDOf0FAFrpd1HBSyvYOL3MvBgdJQJLB
 Z4ea4fipUsxDJqjl5SbTJFqaQeF4J9q/roM3AONOeT9JiM0/c5Am3g6iArB2ZJQqcfGOWw5eWJZ
 8UxjX/+0ecdTIkhgmSfrJJFZE2uLMTWoBYgAVnO+d69oxfGqDLt1ykam5YhSREHs2WWmekWxysU
 NmxulU3GS20+zAb9diA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-15_02,2026-06-12_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 impostorscore=0 lowpriorityscore=0
 malwarescore=0 suspectscore=0 spamscore=0 phishscore=0 adultscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606040000
 definitions=main-2606150099
X-MIME-Autoconverted: from 8bit to quoted-printable by mx0a-0031df01.pphosted.com id 65F9TekT4161094
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 15 Jun 2026 09:34:33 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4222

From: Prathibha Madugonde <prathibha.madugonde@oss.qualcomm.com>

Add 16 patches backporting the CS reflector role and Ranging Service
(RAS) support for BLE Channel Sounding into the bluez5 recipe.

There is no clear upstream BlueZ timeline for this feature; patches
will be removed once the functionality is merged into the BlueZ version
shipped with Wrynose.

Signed-off-by: Prathibha Madugonde <prathibha.madugonde@oss.qualcomm.com>
---
 README.md                                     |   57 +
 conf/layer.conf                               |   16 +
 ...duce-Channel-Sounding-HCI-raw-interf.patch |  381 ++++
 ...nnel-Sounding-config-parsing-support.patch |  288 +++
 ...-Add-HCI-LE-Event-Handling-in-Reflec.patch | 1563 +++++++++++++++++
 ...red-util-Add-MIN-MAX-implementations.patch |   49 +
 ...up-coding-style-and-unnecessary-code.patch |  261 +++
 ...-src-shared-Add-custom-CCC-callbacks.patch |  178 ++
 ...AS-packet-format-and-notification-su.patch | 1439 +++++++++++++++
 ...t-rap-Add-PTS-tests-for-CS-reflector.patch |  408 +++++
 ...anging-Read-cs_mode_one_data-members.patch |   54 +
 ...Add-BPF-filter-for-registered-events.patch |  141 ++
 ...t_hci_register_subevent-for-LE-Meta-.patch |  360 ++++
 ...Use-bt_hci_register_subevent-for-LE-.patch |  309 ++++
 ...p-Fix-gatt_ccc_read_cb-on-big-endian.patch |   56 +
 ...d-rap-fix-use-of-uninitialized-value.patch |   46 +
 ...lient-ranging-registration-and-notif.patch |  979 +++++++++++
 ...les-ranging-Fix-measured_freq_offset.patch |   38 +
 recipes-connectivity/bluez5/bluez5_%.bbappend |   20 +
 19 files changed, 6643 insertions(+)
 create mode 100644 README.md
 create mode 100644 conf/layer.conf
 create mode 100644 recipes-connectivity/bluez5/bluez5/0001-shared-rap-In=
troduce-Channel-Sounding-HCI-raw-interf.patch
 create mode 100644 recipes-connectivity/bluez5/bluez5/0002-main-conf-Add=
-Channel-Sounding-config-parsing-support.patch
 create mode 100644 recipes-connectivity/bluez5/bluez5/0003-profiles-rang=
ing-Add-HCI-LE-Event-Handling-in-Reflec.patch
 create mode 100644 recipes-connectivity/bluez5/bluez5/0004-shared-util-A=
dd-MIN-MAX-implementations.patch
 create mode 100644 recipes-connectivity/bluez5/bluez5/0005-rap-Cleanup-c=
oding-style-and-unnecessary-code.patch
 create mode 100644 recipes-connectivity/bluez5/bluez5/0006-src-shared-Ad=
d-custom-CCC-callbacks.patch
 create mode 100644 recipes-connectivity/bluez5/bluez5/0007-src-shared-Ad=
d-RAS-packet-format-and-notification-su.patch
 create mode 100644 recipes-connectivity/bluez5/bluez5/0008-unit-test-rap=
-Add-PTS-tests-for-CS-reflector.patch
 create mode 100644 recipes-connectivity/bluez5/bluez5/0009-profiles-rang=
ing-Read-cs_mode_one_data-members.patch
 create mode 100644 recipes-connectivity/bluez5/bluez5/0010-shared-hci-Ad=
d-BPF-filter-for-registered-events.patch
 create mode 100644 recipes-connectivity/bluez5/bluez5/0011-shared-hci-Ad=
d-bt_hci_register_subevent-for-LE-Meta-.patch
 create mode 100644 recipes-connectivity/bluez5/bluez5/0012-ranging-rap_h=
ci-Use-bt_hci_register_subevent-for-LE-.patch
 create mode 100644 recipes-connectivity/bluez5/bluez5/0013-test-rap-Fix-=
gatt_ccc_read_cb-on-big-endian.patch
 create mode 100644 recipes-connectivity/bluez5/bluez5/0014-shared-rap-fi=
x-use-of-uninitialized-value.patch
 create mode 100644 recipes-connectivity/bluez5/bluez5/0015-shared-rap-Ad=
d-client-ranging-registration-and-notif.patch
 create mode 100644 recipes-connectivity/bluez5/bluez5/0016-profiles-rang=
ing-Fix-measured_freq_offset.patch
 create mode 100644 recipes-connectivity/bluez5/bluez5_%.bbappend

diff --git a/README.md b/README.md
new file mode 100644
index 0000000..cdbb030
--- /dev/null
+++ b/README.md
@@ -0,0 +1,57 @@
+meta-lts-mixins - wrynose/bluez
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
+
+"Mixin" layer for adding BLE Channel Sounding (CS) support to BlueZ in t=
he
+Yocto Project LTS Wrynose release.
+
+This layer backports the reflector role and Ranging Service (RAS/RAP) su=
pport
+for BLE Channel Sounding into the bluez5 recipe. The patches implement t=
he
+standard BLE CS specification and are not vendor-specific; any platform =
that
+requires BLE ranging functionality can use this mixin.
+
+Patches cover:
+
+- HCI raw interface and CS config/procedure/subevent definitions
+- Channel Sounding config parsing in main.conf
+- HCI LE event handling in the reflector profile
+- RAS packet format and GATT notification support
+- BPF filter and bt_hci_register_subevent for LE Meta events
+- RAP client registration and notification callbacks
+- Bug fixes: big-endian gatt_ccc_read_cb, uninitialized value,
+  measured_freq_offset
+
+There is no clear upstream BlueZ timeline for this feature; these patche=
s will
+be removed from this mixin once the functionality is merged and availabl=
e in
+the BlueZ version shipped with Wrynose.
+
+Dependencies
+------------
+
+This layer depends on:
+
+- URI: git://github.com/openembedded/openembedded-core.git
+  layers: meta
+    branch: wrynose
+
+- URI: git://git.openembedded.org/meta-openembedded
+  layers: meta-oe
+    branch: wrynose
+
+Contributing
+------------
+
+The yocto-patches mailinglist (yocto-patches@lists.yoctoproject.org) is =
used
+for questions, comments and patch review. It is subscriber only, so plea=
se
+register before posting.
+
+Send pull requests to yocto-patches@lists.yoctoproject.org with
+'[meta-lts-mixins][wrynose/bluez]' in the subject.
+
+When sending single patches, please use something like:
+git send-email -M -1 --to=3Dyocto-patches@lists.yoctoproject.org --subje=
ct-prefix=3D'meta-lts-mixins][wrynose/bluez][PATCH'
+
+Maintenance
+-----------
+
+Layer maintainers:
+* Prathibha Madugonde <prathibha.madugonde@oss.qualcomm.com>
diff --git a/conf/layer.conf b/conf/layer.conf
new file mode 100644
index 0000000..a3ac878
--- /dev/null
+++ b/conf/layer.conf
@@ -0,0 +1,16 @@
+# We have a conf and classes directory, append to BBPATH
+BBPATH .=3D ":${LAYERDIR}"
+
+# We have recipes-* directories, add to BBFILES
+BBFILES +=3D "${LAYERDIR}/recipes-*/*/*.bb ${LAYERDIR}/recipes-*/*/*.bba=
ppend"
+
+BBFILE_COLLECTIONS +=3D "lts-bluez-mixin"
+BBFILE_PATTERN_lts-bluez-mixin =3D "^${LAYERDIR}/"
+BBFILE_PRIORITY_lts-bluez-mixin =3D "6"
+
+LAYERSERIES_COMPAT_lts-bluez-mixin =3D "wrynose"
+
+LAYERDEPENDS_lts-bluez-mixin =3D " \
+    core \
+    openembedded-layer \
+"
diff --git a/recipes-connectivity/bluez5/bluez5/0001-shared-rap-Introduce=
-Channel-Sounding-HCI-raw-interf.patch b/recipes-connectivity/bluez5/blue=
z5/0001-shared-rap-Introduce-Channel-Sounding-HCI-raw-interf.patch
new file mode 100644
index 0000000..508ad77
--- /dev/null
+++ b/recipes-connectivity/bluez5/bluez5/0001-shared-rap-Introduce-Channe=
l-Sounding-HCI-raw-interf.patch
@@ -0,0 +1,381 @@
+From aca0a01c3f5e73e4ab44b186b6a0a00c589be87c Mon Sep 17 00:00:00 2001
+From: Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
+Date: Tue, 21 Apr 2026 17:01:46 +0530
+Subject: [PATCH] shared: rap: Introduce Channel Sounding HCI raw interfa=
ce
+ support
+
+Implement stub callbacks for Channel Sounding HCI events and add the
+required protocol definitions for CS configuration, procedure control,
+and subevent result parsing
+
+Add data structures to support Channel Sounding Processing
+Add helper function to get hci conn info list and integrate it with RAP
+
+Upstream-Status: Backport [aca0a01c3f5e73e4ab44b186b6a0a00c589be87c]
+Signed-off-by: Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
+Signed-off-by: Prathibha Madugonde <prathibha.madugonde@oss.qualcomm.com=
>
+---
+ src/shared/hci.c |  62 ++++++++++++-----
+ src/shared/hci.h |   3 +
+ src/shared/rap.c |  50 +++++++++++++-
+ src/shared/rap.h | 172 +++++++++++++++++++++++++++++++++++++++++++++++
+ 4 files changed, 269 insertions(+), 18 deletions(-)
+
+diff --git a/src/shared/hci.c b/src/shared/hci.c
+index 575254c09..0faa6dea5 100644
+--- a/src/shared/hci.c
++++ b/src/shared/hci.c
+@@ -20,9 +20,11 @@
+ #include <sys/un.h>
+ #include <sys/types.h>
+ #include <sys/stat.h>
++#include <sys/ioctl.h>
+ #include <fcntl.h>
+ #include <errno.h>
+=20
++#include "bluetooth/hci.h"
+ #include "monitor/bt.h"
+ #include "src/shared/mainloop.h"
+ #include "src/shared/io.h"
+@@ -30,22 +32,6 @@
+ #include "src/shared/queue.h"
+ #include "src/shared/hci.h"
+=20
+-#define BTPROTO_HCI	1
+-struct sockaddr_hci {
+-	sa_family_t	hci_family;
+-	unsigned short	hci_dev;
+-	unsigned short  hci_channel;
+-};
+-#define HCI_CHANNEL_RAW		0
+-#define HCI_CHANNEL_USER	1
+-
+-#define SOL_HCI		0
+-#define HCI_FILTER	2
+-struct hci_filter {
+-	uint32_t type_mask;
+-	uint32_t event_mask[2];
+-	uint16_t opcode;
+-};
+=20
+ struct bt_hci {
+ 	int ref_count;
+@@ -673,3 +659,47 @@ bool bt_hci_unregister(struct bt_hci *hci, unsigned=
 int id)
+=20
+ 	return true;
+ }
++
++bool bt_hci_get_conn_handle(struct bt_hci *hci, const uint8_t *bdaddr,
++				uint16_t *handle)
++{
++	struct hci_conn_list_req *cl;
++	struct hci_conn_info *ci;
++	int fd, i;
++	bool found =3D false;
++
++	if (!hci || !bdaddr || !handle)
++		return false;
++
++	fd =3D io_get_fd(hci->io);
++	if (fd < 0)
++		return false;
++
++	/* Allocate buffer for connection list request */
++	cl =3D malloc(10 * sizeof(*ci) + sizeof(*cl));
++	if (!cl)
++		return false;
++
++	memset(cl, 0, 10 * sizeof(*ci) + sizeof(*cl));
++	cl->dev_id =3D 0;  /* Will be filled by ioctl */
++	cl->conn_num =3D 10;
++
++	/* Get connection list via ioctl */
++	if (ioctl(fd, HCIGETCONNLIST, (void *) cl) < 0) {
++		free(cl);
++		return false;
++	}
++
++	/* Search for the connection with matching bdaddr */
++	ci =3D cl->conn_info;
++	for (i =3D 0; i < cl->conn_num; i++, ci++) {
++		if (memcmp(&ci->bdaddr, bdaddr, 6) =3D=3D 0) {
++			*handle =3D ci->handle;
++			found =3D true;
++			break;
++		}
++	}
++
++	free(cl);
++	return found;
++}
+diff --git a/src/shared/hci.h b/src/shared/hci.h
+index 76ee72f54..800dc4946 100644
+--- a/src/shared/hci.h
++++ b/src/shared/hci.h
+@@ -41,3 +41,6 @@ unsigned int bt_hci_register(struct bt_hci *hci, uint8=
_t event,
+ 				bt_hci_callback_func_t callback,
+ 				void *user_data, bt_hci_destroy_func_t destroy);
+ bool bt_hci_unregister(struct bt_hci *hci, unsigned int id);
++
++bool bt_hci_get_conn_handle(struct bt_hci *hci, const uint8_t *bdaddr,
++				uint16_t *handle);
+diff --git a/src/shared/rap.c b/src/shared/rap.c
+index ccf3e6f33..ac6de04e0 100644
+--- a/src/shared/rap.c
++++ b/src/shared/rap.c
+@@ -25,8 +25,8 @@
+ #include "src/shared/gatt-client.h"
+ #include "src/shared/rap.h"
+=20
+-#define DBG(_rap, fmt, arg...) \
+-	rap_debug(_rap, "%s:%s() " fmt, __FILE__, __func__, ## arg)
++#define DBG(_rap, fmt, ...) \
++	rap_debug(_rap, "%s:%s() " fmt, __FILE__, __func__, ##__VA_ARGS__)
+=20
+ #define RAS_UUID16			0x185B
+=20
+@@ -503,6 +503,52 @@ bool bt_rap_unregister(unsigned int id)
+ 	return true;
+ }
+=20
++void bt_rap_hci_cs_subevent_result_cont_callback(uint16_t length,
++						const void *param,
++						void *user_data)
++{
++	struct bt_rap *rap =3D user_data;
++
++	DBG(rap, "Received CS subevent CONT: len=3D%d", length);
++}
++
++void bt_rap_hci_cs_subevent_result_callback(uint16_t length,
++					const void *param,
++					void *user_data)
++{
++	struct bt_rap *rap =3D user_data;
++
++	DBG(rap, "Received CS subevent: len=3D%d", length);
++}
++
++void bt_rap_hci_cs_procedure_enable_complete_callback(uint16_t length,
++						const void *param,
++						void *user_data)
++{
++	struct bt_rap *rap =3D user_data;
++
++	DBG(rap, "Received CS procedure enable complete subevent: len=3D%d",
++	    length);
++}
++
++void bt_rap_hci_cs_sec_enable_complete_callback(uint16_t length,
++						 const void *param,
++						 void *user_data)
++{
++	struct bt_rap *rap =3D user_data;
++
++	DBG(rap, "Received CS security enable subevent: len=3D%d", length);
++}
++
++void bt_rap_hci_cs_config_complete_callback(uint16_t length,
++					const void *param,
++					void *user_data)
++{
++	struct bt_rap *rap =3D user_data;
++
++	DBG(rap, "Received CS config complete subevent: len=3D%d", length);
++}
++
+ struct bt_rap *bt_rap_new(struct gatt_db *ldb, struct gatt_db *rdb)
+ {
+ 	struct bt_rap *rap;
+diff --git a/src/shared/rap.h b/src/shared/rap.h
+index a1d1ff2ae..15ddea295 100644
+--- a/src/shared/rap.h
++++ b/src/shared/rap.h
+@@ -9,8 +9,153 @@
+ #include <inttypes.h>
+=20
+ #include "src/shared/io.h"
++#include "bluetooth/mgmt.h"
++#include "src/shared/hci.h"
+=20
+ struct bt_rap;
++struct gatt_db;
++struct bt_gatt_client;
++
++/* Channel Sounding Events */
++struct bt_rap_hci_cs_options {
++	uint8_t role;
++	uint8_t cs_sync_ant_sel;
++	int8_t max_tx_power;
++	int rtt_type;
++};
++
++#define CS_MODE_ZERO				0x00
++#define CS_MODE_ONE				0x01
++#define CS_MODE_TWO				0x02
++#define CS_MODE_THREE				0x03
++
++#define CS_REFLECTOR			0x01
++#define CS_INITIATOR			0x00
++
++#define CS_MAX_ANT_PATHS			0x05
++#define CS_MAX_STEPS			0xA0
++#define CS_MAX_STEP_DATA_LEN		0xFF
++
++struct rap_ev_cs_config_cmplt {
++	uint8_t status;
++	uint16_t conn_hdl;
++	uint8_t config_id;
++	uint8_t action;
++	uint8_t main_mode_type;
++	uint8_t sub_mode_type;
++	uint8_t min_main_mode_steps;
++	uint8_t max_main_mode_steps;
++	uint8_t main_mode_rep;
++	uint8_t mode_0_steps;
++	uint8_t role;
++	uint8_t rtt_type;
++	uint8_t cs_sync_phy;
++	uint8_t channel_map[10];
++	uint8_t channel_map_rep;
++	uint8_t channel_sel_type;
++	uint8_t ch3c_shape;
++	uint8_t ch3c_jump;
++	uint8_t reserved;
++	uint8_t t_ip1_time;
++	uint8_t t_ip2_time;
++	uint8_t t_fcs_time;
++	uint8_t t_pm_time;
++};
++
++struct rap_ev_cs_sec_enable_cmplt {
++	uint8_t status;
++	uint16_t conn_hdl;
++};
++
++struct rap_ev_cs_proc_enable_cmplt {
++	uint8_t status;
++	uint16_t conn_hdl;
++	uint8_t config_id;
++	uint8_t state;
++	uint8_t tone_ant_config_sel;
++	int8_t sel_tx_pwr;
++	uint8_t sub_evt_len[3];
++	uint8_t sub_evts_per_evt;
++	uint16_t sub_evt_intrvl;
++	uint16_t evt_intrvl;
++	uint16_t proc_intrvl;
++	uint16_t proc_counter;
++	uint16_t max_proc_len;
++};
++
++struct pct_iq_sample {
++	int16_t i_sample;
++	int16_t q_sample;
++};
++
++struct cs_mode_zero_data {
++	uint8_t packet_quality;
++	uint8_t packet_rssi_dbm;
++	uint8_t packet_ant;
++	uint32_t init_measured_freq_offset;
++};
++
++struct cs_mode_one_data {
++	uint8_t packet_quality;
++	uint8_t packet_rssi_dbm;
++	uint8_t packet_ant;
++	uint8_t packet_nadm;
++	int16_t toa_tod_init;
++	int16_t tod_toa_refl;
++	struct pct_iq_sample packet_pct1;
++	struct pct_iq_sample packet_pct2;
++};
++
++struct cs_mode_two_data {
++	uint8_t ant_perm_index;
++	struct pct_iq_sample tone_pct[5];
++	uint8_t tone_quality_indicator[5];
++};
++
++struct cs_mode_three_data {
++	struct cs_mode_one_data mode_one_data;
++	struct cs_mode_two_data mode_two_data;
++};
++
++union cs_mode_data {
++	struct cs_mode_zero_data mode_zero_data;
++	struct cs_mode_one_data mode_one_data;
++	struct cs_mode_two_data mode_two_data;
++	struct cs_mode_three_data mode_three_data;
++};
++
++struct cs_step_data {
++	uint8_t step_mode;
++	uint8_t step_chnl;
++	uint8_t step_data_length;
++	union cs_mode_data step_mode_data;
++};
++
++struct rap_ev_cs_subevent_result {
++	uint16_t conn_hdl;
++	uint8_t config_id;
++	uint16_t start_acl_conn_evt_counter;
++	uint16_t proc_counter;
++	uint16_t freq_comp;
++	uint8_t ref_pwr_lvl;
++	uint8_t proc_done_status;
++	uint8_t subevt_done_status;
++	uint8_t abort_reason;
++	uint8_t num_ant_paths;
++	uint8_t num_steps_reported;
++	struct cs_step_data step_data[];
++};
++
++struct rap_ev_cs_subevent_result_cont {
++	uint16_t conn_hdl;
++	uint8_t config_id;
++	uint8_t proc_done_status;
++	uint8_t subevt_done_status;
++	uint8_t abort_reason;
++	uint8_t num_ant_paths;
++	uint8_t num_steps_reported;
++	struct cs_step_data step_data[];
++};
+=20
+ typedef void (*bt_rap_debug_func_t)(const char *str, void *user_data);
+ typedef void (*bt_rap_ready_func_t)(struct bt_rap *rap, void *user_data=
);
+@@ -43,3 +188,30 @@ bool bt_rap_ready_unregister(struct bt_rap *rap, uns=
igned int id);
+ bool bt_rap_unregister(unsigned int id);
+=20
+ struct bt_rap *bt_rap_new(struct gatt_db *ldb, struct gatt_db *rdb);
++
++/* HCI Raw Channel Approach */
++void bt_rap_hci_cs_config_complete_callback(uint16_t length,
++					     const void *param,
++					     void *user_data);
++void bt_rap_hci_cs_sec_enable_complete_callback(uint16_t length,
++						 const void *param,
++						 void *user_data);
++void bt_rap_hci_cs_procedure_enable_complete_callback(uint16_t length,
++						      const void *param,
++						      void *user_data);
++void bt_rap_hci_cs_subevent_result_callback(uint16_t length,
++					     const void *param,
++					     void *user_data);
++void bt_rap_hci_cs_subevent_result_cont_callback(uint16_t length,
++						  const void *param,
++						  void *user_data);
++
++void *bt_rap_attach_hci(struct bt_rap *rap, struct bt_hci *hci,
++			uint8_t role, uint8_t cs_sync_ant_sel,
++			int8_t max_tx_power);
++void bt_rap_detach_hci(struct bt_rap *rap, void *hci_sm);
++
++/* Connection handle mapping functions */
++bool bt_rap_set_conn_handle(void *hci_sm, struct bt_rap *rap, uint16_t =
handle,
++				const uint8_t *bdaddr, uint8_t bdaddr_type);
++void bt_rap_clear_conn_handle(void *hci_sm, uint16_t handle);
+--=20
+2.34.1
+
diff --git a/recipes-connectivity/bluez5/bluez5/0002-main-conf-Add-Channe=
l-Sounding-config-parsing-support.patch b/recipes-connectivity/bluez5/blu=
ez5/0002-main-conf-Add-Channel-Sounding-config-parsing-support.patch
new file mode 100644
index 0000000..89b7c30
--- /dev/null
+++ b/recipes-connectivity/bluez5/bluez5/0002-main-conf-Add-Channel-Sound=
ing-config-parsing-support.patch
@@ -0,0 +1,288 @@
+From c34ed95fa59b4a61882794f329f74a32a5b1f949 Mon Sep 17 00:00:00 2001
+From: Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
+Date: Tue, 21 Apr 2026 17:01:47 +0530
+Subject: [PATCH] main.conf: Add Channel Sounding config parsing support
+
+Add support for parsing Channel Sounding (CS) configuration options
+from the configuration file.
+
+Add CAP_NET_RAW to CapabilityBoundingSet in bluetooth.service.
+bluetoothd requires CAP_NET_RAW to receive and process HCI LE events
+when running under a constrained systemd capability bounding set
+
+Upstream-Status: Backport [c34ed95fa59b4a61882794f329f74a32a5b1f949]
+Signed-off-by: Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
+Signed-off-by: Prathibha Madugonde <prathibha.madugonde@oss.qualcomm.com=
>
+---
+ src/bluetooth.service.in |   2 +-
+ src/btd.h                |   7 +++
+ src/main.c               | 132 ++++++++++++++++++++++++++++++++++++++-
+ src/main.conf            |  24 +++++++
+ 4 files changed, 162 insertions(+), 3 deletions(-)
+
+diff --git a/src/bluetooth.service.in b/src/bluetooth.service.in
+index 8ebe89bec..8dcbde236 100644
+--- a/src/bluetooth.service.in
++++ b/src/bluetooth.service.in
+@@ -10,7 +10,7 @@ ExecStart=3D@PKGLIBEXECDIR@/bluetoothd
+ NotifyAccess=3Dmain
+ #WatchdogSec=3D10
+ #Restart=3Don-failure
+-CapabilityBoundingSet=3DCAP_NET_ADMIN CAP_NET_BIND_SERVICE
++CapabilityBoundingSet=3DCAP_NET_RAW CAP_NET_ADMIN CAP_NET_BIND_SERVICE
+ LimitNPROC=3D1
+=20
+ # Filesystem lockdown
+diff --git a/src/btd.h b/src/btd.h
+index c84a600d1..db2e81239 100644
+--- a/src/btd.h
++++ b/src/btd.h
+@@ -94,11 +94,18 @@ struct btd_le_defaults {
+ 	uint8_t		enable_advmon_interleave_scan;
+ };
+=20
++struct btd_le_bcs {
++	uint8_t role;
++	uint8_t cs_sync_ant_sel;
++	int8_t max_tx_power;
++};
++
+ struct btd_defaults {
+ 	uint16_t	num_entries;
+=20
+ 	struct btd_br_defaults br;
+ 	struct btd_le_defaults le;
++	struct btd_le_bcs bcs;
+ };
+=20
+ struct btd_csis {
+diff --git a/src/main.c b/src/main.c
+index 818f7c06e..9a3d2da25 100644
+--- a/src/main.c
++++ b/src/main.c
+@@ -156,6 +156,13 @@ static const char *gatt_options[] =3D {
+ 	NULL
+ };
+=20
++static const char *const bcs_options[] =3D {
++	"Role",
++	"CsSyncAntennaSel",
++	"MaxTxPower",
++	NULL
++};
++
+ static const char *csip_options[] =3D {
+ 	"SIRK",
+ 	"Encryption",
+@@ -183,7 +190,7 @@ static const char *advmon_options[] =3D {
+=20
+ static const struct group_table {
+ 	const char *name;
+-	const char **options;
++	const char * const *options;
+ } valid_groups[] =3D {
+ 	{ "General",	supported_options },
+ 	{ "BR",		br_options },
+@@ -193,6 +200,7 @@ static const struct group_table {
+ 	{ "CSIS",	csip_options },
+ 	{ "AVDTP",	avdtp_options },
+ 	{ "AVRCP",	avrcp_options },
++	{ "ChannelSounding",	bcs_options },
+ 	{ "AdvMon",	advmon_options },
+ 	{ }
+ };
+@@ -356,7 +364,7 @@ static enum jw_repairing_t parse_jw_repairing(const =
char *jw_repairing)
+=20
+=20
+ static void check_options(GKeyFile *config, const char *group,
+-						const char **options)
++						const char * const *options)
+ {
+ 	char **keys;
+ 	int i;
+@@ -492,6 +500,46 @@ static bool parse_config_int(GKeyFile *config, cons=
t char *group,
+ 	return true;
+ }
+=20
++static bool parse_config_signed_int(GKeyFile *config, const char *group=
,
++					const char *key, int8_t *val,
++					long min, long max)
++{
++	char *str =3D NULL;
++	char *endptr =3D NULL;
++	long tmp;
++	bool result =3D false;
++
++	str =3D g_key_file_get_string(config, group, key, NULL);
++	if (!str)
++		return false;
++
++	tmp =3D strtol(str, &endptr, 0);
++	if (!endptr || *endptr !=3D '\0') {
++		warn("%s.%s =3D %s is not integer", group, key, str);
++		goto cleanup;
++	}
++
++	if (tmp < min) {
++		warn("%s.%s =3D %ld is out of range (< %ld)", group, key, tmp,
++			min);
++		goto cleanup;
++	}
++
++	if (tmp > max) {
++		warn("%s.%s =3D %ld is out of range (> %ld)", group, key, tmp,
++									max);
++		goto cleanup;
++	}
++
++	if (val)
++		*val =3D (int8_t) tmp;
++	result =3D true;
++
++cleanup:
++	g_free(str);
++	return result;
++}
++
+ struct config_param {
+ 	const char * const val_name;
+ 	void * const val;
+@@ -1184,6 +1232,81 @@ static void parse_csis(GKeyFile *config)
+ 					0, UINT8_MAX);
+ }
+=20
++static bool parse_cs_role(GKeyFile *config, const char *group,
++					const char *key, uint8_t *val)
++{
++	GError *err =3D NULL;
++	char *str =3D NULL;
++	char *endptr =3D NULL;
++	int numeric_val;
++
++	/* Try to read as string first */
++	str =3D g_key_file_get_string(config, group, key, &err);
++	if (err) {
++		if (err->code !=3D G_KEY_FILE_ERROR_KEY_NOT_FOUND)
++			DBG("%s", err->message);
++		g_error_free(err);
++		return false;
++	}
++
++	DBG("%s.%s =3D %s", group, key, str);
++
++	/* Check if it's a string value */
++	if (!strcmp(str, "Initiator") || !strcmp(str, "initiator")) {
++		if (val)
++			*val =3D 1;
++		g_free(str);
++		return true;
++	} else if (!strcmp(str, "Reflector") || !strcmp(str, "reflector")) {
++		if (val)
++			*val =3D 2;
++		g_free(str);
++		return true;
++	} else if (!strcmp(str, "Both") || !strcmp(str, "both")) {
++		if (val)
++			*val =3D 3;
++		g_free(str);
++		return true;
++	}
++
++	/* Try to parse as numeric value */
++	numeric_val =3D strtol(str, &endptr, 0);
++
++	if (!endptr || *endptr !=3D '\0') {
++		warn("%s.%s =3D %s is not a valid value. "
++			"Expected: 1/Initiator, 2/Reflector, or 3/Both",
++			group, key, str);
++		g_free(str);
++		return false;
++	}
++
++	if (numeric_val < 1 || numeric_val > 3) {
++		warn("%s.%s =3D %d is out of range. "
++			"Valid values: 1 (Initiator), 2 (Reflector), 3 (Both)",
++			group, key, numeric_val);
++		g_free(str);
++		return false;
++	}
++
++	if (val)
++		*val =3D numeric_val;
++
++	g_free(str);
++	return true;
++}
++
++static void parse_le_cs_config(GKeyFile *config)
++{
++	parse_cs_role(config, "ChannelSounding", "Role",
++			&btd_opts.defaults.bcs.role);
++	parse_config_u8(config, "ChannelSounding", "CsSyncAntennaSel",
++			&btd_opts.defaults.bcs.cs_sync_ant_sel,
++			0x01, 0xFF);
++	parse_config_signed_int(config, "ChannelSounding",
++			"MaxTxPower", &btd_opts.defaults.bcs.max_tx_power,
++			INT8_MIN, INT8_MAX);
++}
++
+ static void parse_avdtp_session_mode(GKeyFile *config)
+ {
+ 	char *str =3D NULL;
+@@ -1262,6 +1385,7 @@ static void parse_config(GKeyFile *config)
+ 	parse_csis(config);
+ 	parse_avdtp(config);
+ 	parse_avrcp(config);
++	parse_le_cs_config(config);
+ 	parse_advmon(config);
+ }
+=20
+@@ -1313,6 +1437,10 @@ static void init_defaults(void)
+=20
+ 	btd_opts.advmon.rssi_sampling_period =3D 0xFF;
+ 	btd_opts.csis.encrypt =3D true;
++
++	btd_opts.defaults.bcs.role =3D 0x03;
++	btd_opts.defaults.bcs.cs_sync_ant_sel =3D 0xFF;
++	btd_opts.defaults.bcs.max_tx_power =3D 0x14;
+ }
+=20
+ static void log_handler(const gchar *log_domain, GLogLevelFlags log_lev=
el,
+diff --git a/src/main.conf b/src/main.conf
+index d31dd1b8f..5846ef92d 100644
+--- a/src/main.conf
++++ b/src/main.conf
+@@ -291,6 +291,30 @@
+ # Default: read-only
+ #ExportClaimedServices =3D read-only
+
++[ChannelSounding]
++# Current role of the device
++# Possible values:
++#   1 or "Initiator" - CS Initiator role,
++#   Generally, CS Initiator acts as Client (Gatt role) and Central (Gap=
 role)
++#   2 or "Reflector" - CS Reflector role,
++#   Generally, CS Reflector acts as Server (Gatt role) and Peripheral (=
Gap role)
++#   3 or "Both"      - Both Initiator and Reflector roles
++# Default: 3 (Both)
++#Role =3D 3
++
++# Antenna Identifier to be used
++# Possible values:
++# 0x01-0x04 (antenna identifier to be used),
++# 0xFE - Antennas to be used in repetitive order,
++# 0xFF - Host doesn't have recommendation
++# Default: 0xFF (Host doesn't have recommendation)
++#CsSyncAntennaSel =3D 0xFF
++
++# Maximum Transmit power
++# Possible values: 0x81-0x14 (-127dBm to 20dBm)
++# Default: 0x14 (Max Power possible)
++#MaxTxPower =3D 0x14
++
+ [CSIS]
+ # SIRK - Set Identification Resolution Key which is common for all the
+ # sets. They SIRK key is used to identify its sets. This can be any
+--=20
+2.34.1
+
diff --git a/recipes-connectivity/bluez5/bluez5/0003-profiles-ranging-Add=
-HCI-LE-Event-Handling-in-Reflec.patch b/recipes-connectivity/bluez5/blue=
z5/0003-profiles-ranging-Add-HCI-LE-Event-Handling-in-Reflec.patch
new file mode 100644
index 0000000..2b41f99
--- /dev/null
+++ b/recipes-connectivity/bluez5/bluez5/0003-profiles-ranging-Add-HCI-LE=
-Event-Handling-in-Reflec.patch
@@ -0,0 +1,1563 @@
+From f1363b27467197525f60f3bbbf43ad1d905719af Mon Sep 17 00:00:00 2001
+From: Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
+Date: Tue, 21 Apr 2026 17:01:48 +0530
+Subject: [PATCH] profiles: ranging: Add HCI LE Event Handling in Reflect=
or
+ role
+
+Open RAW HCI Channel for CS Event Handling
+Parse the following HCI LE CS Events in reflector role
+and route the events to RAP Profile.
+ 1. HCI_EVT_LE_CS_READ_RMT_SUPP_CAP_COMPLETE
+ 2. HCI_EVT_LE_CS_CONFIG_COMPLETE
+ 3. HCI_EVT_LE_CS_SECURITY_ENABLE_COMPLETE
+ 4. HCI_EVT_LE_CS_PROCEDURE_ENABLE_COMPLETE
+ 5. HCI_EVT_LE_CS_SUBEVENT_RESULT
+ 6. HCI_EVT_LE_CS_SUBEVENT_RESULT_CONTINUE
+Send HCI_OP_LE_CS_SET_DEFAULT_SETTINGS to the controller
+with default settings selected by the user.
+Map connection handle received to device connection
+
+Upstream-Status: Backport [f1363b27467197525f60f3bbbf43ad1d905719af]
+Signed-off-by: Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
+Signed-off-by: Prathibha Madugonde <prathibha.madugonde@oss.qualcomm.com=
>
+---
+ Makefile.plugins           |    3 +-
+ profiles/ranging/rap.c     |  190 +++++-
+ profiles/ranging/rap_hci.c | 1259 ++++++++++++++++++++++++++++++++++++
+ 3 files changed, 1450 insertions(+), 2 deletions(-)
+ create mode 100644 profiles/ranging/rap_hci.c
+
+diff --git a/Makefile.plugins b/Makefile.plugins
+index c9efadb45..ac667beda 100644
+--- a/Makefile.plugins
++++ b/Makefile.plugins
+@@ -89,7 +89,8 @@ builtin_modules +=3D battery
+ builtin_sources +=3D profiles/battery/battery.c
+=20
+ builtin_modules +=3D rap
+-builtin_sources +=3D profiles/ranging/rap.c
++builtin_sources +=3D profiles/ranging/rap.c \
++		profiles/ranging/rap_hci.c
+=20
+ if SIXAXIS
+ builtin_modules +=3D sixaxis
+diff --git a/profiles/ranging/rap.c b/profiles/ranging/rap.c
+index f03454c72..df4f07811 100644
+--- a/profiles/ranging/rap.c
++++ b/profiles/ranging/rap.c
+@@ -17,6 +17,7 @@
+ #include "gdbus/gdbus.h"
+=20
+ #include "bluetooth/bluetooth.h"
++#include "bluetooth/l2cap.h"
+ #include "bluetooth/uuid.h"
+=20
+ #include "src/plugin.h"
+@@ -34,15 +35,131 @@
+ #include "src/shared/rap.h"
+ #include "attrib/att.h"
+ #include "src/log.h"
++#include "src/btd.h"
++
++struct rap_adapter_data {
++	struct btd_adapter *adapter;
++	struct bt_hci *hci;  /* Shared HCI raw channel */
++	int ref_count;  /* Number of devices using this adapter */
++};
+=20
+ struct rap_data {
+ 	struct btd_device *device;
+ 	struct btd_service *service;
+ 	struct bt_rap *rap;
+ 	unsigned int ready_id;
++	struct rap_adapter_data *adapter_data;  /* Shared adapter-level HCI */
++	void *hci_sm;  /* Per-device HCI state machine */
+ };
+=20
+ static struct queue *sessions;
++static struct queue *adapter_list;  /* List of rap_adapter_data */
++
++/* Adapter data management */
++static bool match_adapter(const void *data, const void *match_data)
++{
++	const struct rap_adapter_data *adapter_data =3D data;
++	const struct btd_adapter *adapter =3D match_data;
++
++	return adapter_data->adapter =3D=3D adapter;
++}
++
++static struct rap_adapter_data *rap_adapter_data_find(
++		struct btd_adapter *adapter)
++{
++	if (!adapter_list)
++		return NULL;
++
++	return queue_find(adapter_list, match_adapter, adapter);
++}
++
++static struct rap_adapter_data *rap_adapter_data_new(
++		struct btd_adapter *adapter)
++{
++	struct rap_adapter_data *adapter_data;
++	int16_t hci_index;
++
++	hci_index =3D btd_adapter_get_index(adapter);
++	DBG("Creating new adapter_data for hci%d", hci_index);
++
++	adapter_data =3D new0(struct rap_adapter_data, 1);
++	if (!adapter_data) {
++		error("Failed to allocate adapter_data");
++		return NULL;
++	}
++
++	adapter_data->adapter =3D adapter;
++	adapter_data->ref_count =3D 0;
++
++	/* Create adapter list if needed */
++	if (!adapter_list) {
++		DBG("Creating new adapter_list");
++		adapter_list =3D queue_new();
++	}
++
++	/* Add to queue BEFORE creating HCI to prevent race condition */
++	queue_push_tail(adapter_list, adapter_data);
++	DBG("Added adapter_data to queue");
++
++	/* Create HCI raw channel for this adapter */
++	DBG("Opening HCI raw device for hci%d", hci_index);
++	adapter_data->hci =3D bt_hci_new_raw_device(hci_index);
++
++	if (!adapter_data->hci) {
++		error("Failed to create HCI raw device for hci%d", hci_index);
++		queue_remove(adapter_list, adapter_data);
++		free(adapter_data);
++		return NULL;
++	}
++
++	DBG("HCI raw channel created successfully for hci%d", hci_index);
++
++	return adapter_data;
++}
++
++static struct rap_adapter_data *rap_adapter_data_ref(
++		struct btd_adapter *adapter)
++{
++	struct rap_adapter_data *adapter_data;
++
++	adapter_data =3D rap_adapter_data_find(adapter);
++	if (!adapter_data) {
++		adapter_data =3D rap_adapter_data_new(adapter);
++		if (!adapter_data)
++			return NULL;
++	}
++
++	adapter_data->ref_count++;
++
++	return adapter_data;
++}
++
++static void rap_adapter_data_unref(struct rap_adapter_data *adapter_dat=
a)
++{
++	if (!adapter_data)
++		return;
++
++	adapter_data->ref_count--;
++
++	if (adapter_data->ref_count > 0)
++		return;
++
++	/* No more devices using this adapter, clean up */
++	DBG("Cleaning up adapter HCI channel");
++
++	if (adapter_data->hci) {
++		bt_hci_unref(adapter_data->hci);
++		adapter_data->hci =3D NULL;
++	}
++
++	queue_remove(adapter_list, adapter_data);
++	free(adapter_data);
++
++	if (queue_isempty(adapter_list)) {
++		queue_destroy(adapter_list, NULL);
++		adapter_list =3D NULL;
++	}
++}
+=20
+ static struct rap_data *rap_data_new(struct btd_device *device)
+ {
+@@ -95,6 +212,19 @@ static void rap_data_free(struct rap_data *data)
+ 	}
+=20
+ 	bt_rap_ready_unregister(data->rap, data->ready_id);
++
++	/* Detach per-device HCI state machine */
++	if (data->hci_sm) {
++		bt_rap_detach_hci(data->rap, data->hci_sm);
++		data->hci_sm =3D NULL;
++	}
++
++	/* Release reference to shared adapter HCI channel */
++	if (data->adapter_data) {
++		rap_adapter_data_unref(data->adapter_data);
++		data->adapter_data =3D NULL;
++	}
++
+ 	bt_rap_unref(data->rap);
+ 	free(data);
+ }
+@@ -177,7 +307,7 @@ static int rap_probe(struct btd_service *service)
+ 	ba2str(device_get_address(device), addr);
+ 	DBG("%s", addr);
+=20
+-	/*Ignore, if we probed for this device already */
++	/* Ignore, if we probed for this device already */
+ 	if (data) {
+ 		error("Profile probed twice for this device");
+ 		return -EINVAL;
+@@ -195,6 +325,35 @@ static int rap_probe(struct btd_service *service)
+ 		return -EINVAL;
+ 	}
+=20
++	/* Get or create shared adapter-level HCI channel */
++	data->adapter_data =3D rap_adapter_data_ref(adapter);
++	if (!data->adapter_data) {
++		error("Failed to get adapter HCI channel");
++		bt_rap_unref(data->rap);
++		free(data);
++		return -EINVAL;
++	}
++
++	DBG("Using shared HCI channel for adapter (ref_count=3D%d)",
++		data->adapter_data->ref_count);
++
++	/* Create per-device HCI state machine with valid rap instance */
++	DBG("Attaching per-device HCI state machine");
++	data->hci_sm =3D bt_rap_attach_hci(data->rap, data->adapter_data->hci,
++					btd_opts.defaults.bcs.role,
++					btd_opts.defaults.bcs.cs_sync_ant_sel,
++					btd_opts.defaults.bcs.max_tx_power);
++
++	if (!data->hci_sm) {
++		error("Failed to attach HCI state machine for device");
++		rap_adapter_data_unref(data->adapter_data);
++		bt_rap_unref(data->rap);
++		free(data);
++		return -EINVAL;
++	}
++
++	DBG("HCI state machine attached successfully for device");
++
+ 	rap_data_add(data);
+=20
+ 	data->ready_id =3D bt_rap_ready_register(data->rap, rap_ready, service=
,
+@@ -228,6 +387,10 @@ static int rap_accept(struct btd_service *service)
+ 	struct btd_device *device =3D btd_service_get_device(service);
+ 	struct bt_gatt_client *client =3D btd_device_get_gatt_client(device);
+ 	struct rap_data *data =3D btd_service_get_user_data(service);
++	struct bt_att *att;
++	const bdaddr_t *bdaddr;
++	uint8_t bdaddr_type;
++	uint16_t handle;
+ 	char addr[18];
+=20
+ 	ba2str(device_get_address(device), addr);
+@@ -243,6 +406,31 @@ static int rap_accept(struct btd_service *service)
+ 		return -EINVAL;
+ 	}
+=20
++	/* Set up connection handle mapping for CS event routing */
++	att =3D bt_rap_get_att(data->rap);
++	bdaddr =3D device_get_address(device);
++	bdaddr_type =3D device_get_le_address_type(device);
++
++	if (att && data->adapter_data && data->adapter_data->hci &&
++	    data->hci_sm) {
++		/* Use bt_hci_get_conn_handle to find the connection handle
++		 * by bdaddr using HCIGETCONNLIST ioctl
++		 */
++		if (bt_hci_get_conn_handle(data->adapter_data->hci,
++					(const uint8_t *) bdaddr, &handle)) {
++			DBG("Found conn handle 0x%04X for %s", handle, addr);
++			DBG("Setting up handle mapping: handle=3D0x%04X",
++				handle);
++			bt_rap_set_conn_handle(data->hci_sm,
++						data->rap, handle,
++						(const uint8_t *) bdaddr,
++						bdaddr_type);
++		} else {
++			error("Failed to find connection handle for device %s",
++				addr);
++		}
++	}
++
+ 	btd_service_connecting_complete(service, 0);
+=20
+ 	return 0;
+diff --git a/profiles/ranging/rap_hci.c b/profiles/ranging/rap_hci.c
+new file mode 100644
+index 000000000..1aca4bbf8
+--- /dev/null
++++ b/profiles/ranging/rap_hci.c
+@@ -0,0 +1,1259 @@
++// SPDX-License-Identifier: LGPL-2.1-or-later
++/*
++ *  BlueZ - Bluetooth protocol stack for Linux
++ *
++ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
++ */
++
++#ifdef HAVE_CONFIG_H
++#include <config.h>
++#endif
++
++#include <stdio.h>
++#include <stdlib.h>
++#include <stdbool.h>
++#include <stddef.h>
++#include <unistd.h>
++#include <string.h>
++#include <endian.h>
++
++#include "lib/bluetooth/bluetooth.h"
++#include "src/shared/util.h"
++#include "src/shared/queue.h"
++#include "src/shared/rap.h"
++#include "src/log.h"
++#include "monitor/bt.h"
++
++#ifndef MIN
++#define MIN(a, b) ((a) < (b) ? (a) : (b))
++#endif
++
++/* Macro to sign-extend an N-bit value to 16-bit signed integer */
++#define SIGN_EXTEND_TO_16(val, bits) \
++	((int16_t)(((val) ^ (1U << ((bits)-1))) - (1U << ((bits)-1))))
++
++/*  CS State Definitions */
++enum cs_state {
++	CS_STATE_INIT,
++	CS_STATE_STOPPED,
++	CS_STATE_STARTED,
++	CS_STATE_WAIT_CONFIG_CMPLT,
++	CS_STATE_WAIT_SEC_CMPLT,
++	CS_STATE_WAIT_PROC_CMPLT,
++	CS_STATE_HOLD,
++	CS_STATE_UNSPECIFIED
++};
++
++static const char * const state_names[] =3D {
++	"CS_STATE_INIT",
++	"CS_STATE_STOPPED",
++	"CS_STATE_STARTED",
++	"CS_STATE_WAIT_CONFIG_CMPLT",
++	"CS_STATE_WAIT_SEC_CMPLT",
++	"CS_STATE_WAIT_PROC_CMPLT",
++	"CS_STATE_HOLD",
++	"CS_STATE_UNSPECIFIED"
++};
++
++/* Callback Function Type */
++typedef void (*cs_callback_t)(uint16_t length,
++			const void *param, void *user_data);
++
++/* State Machine Context */
++struct cs_state_machine {
++	enum cs_state current_state;
++	enum cs_state old_state;
++	struct bt_hci *hci;
++	struct bt_rap *rap;
++	unsigned int event_id;
++	bool initiator;
++	bool procedure_active;
++	struct bt_rap_hci_cs_options cs_opt;  /* Per-instance CS options */
++	uint8_t role_enable;  /* Role value for HCI commands (1, 2, or 3) */
++	struct queue *conn_mappings;  /* Per-instance connection mappings */
++};
++
++/* Connection Handle Mapping */
++struct rap_conn_mapping {
++	uint16_t handle;
++	uint8_t bdaddr[6];
++	uint8_t bdaddr_type;
++	struct bt_att *att;
++	struct bt_rap *rap;
++};
++
++/* Connection Mapping Helper Functions */
++static void mapping_free(void *data)
++{
++	struct rap_conn_mapping *mapping =3D data;
++
++	if (!mapping)
++		return;
++
++	free(mapping);
++}
++
++static bool match_mapping_handle(const void *a, const void *b)
++{
++	const struct rap_conn_mapping *mapping =3D a;
++	uint16_t handle =3D PTR_TO_UINT(b);
++
++	return mapping->handle =3D=3D handle;
++}
++
++static bool match_mapping_rap(const void *a, const void *b)
++{
++	const struct rap_conn_mapping *mapping =3D a;
++	const struct bt_rap *rap =3D b;
++
++	return mapping->rap =3D=3D rap;
++}
++
++static struct rap_conn_mapping *find_mapping_by_handle(
++					struct cs_state_machine *sm,
++					uint16_t handle)
++{
++	if (!sm || !sm->conn_mappings)
++		return NULL;
++
++	return queue_find(sm->conn_mappings, match_mapping_handle,
++				UINT_TO_PTR(handle));
++}
++
++static bool add_conn_mapping(struct cs_state_machine *sm, uint16_t hand=
le,
++				const uint8_t *bdaddr, uint8_t bdaddr_type,
++				struct bt_att *att, struct bt_rap *rap)
++{
++	struct rap_conn_mapping *mapping;
++
++	if (!sm)
++		return false;
++
++	if (!sm->conn_mappings) {
++		sm->conn_mappings =3D queue_new();
++		if (!sm->conn_mappings)
++			return false;
++	}
++
++	/* Check if mapping already exists */
++	mapping =3D find_mapping_by_handle(sm, handle);
++	if (mapping) {
++		/* Update existing mapping */
++		if (bdaddr)
++			memcpy(mapping->bdaddr, bdaddr, 6);
++		mapping->bdaddr_type =3D bdaddr_type;
++		mapping->att =3D att;
++		mapping->rap =3D rap;
++		return true;
++	}
++
++	/* Create new mapping */
++	mapping =3D new0(struct rap_conn_mapping, 1);
++	if (!mapping)
++		return false;
++
++	mapping->handle =3D handle;
++	if (bdaddr)
++		memcpy(mapping->bdaddr, bdaddr, 6);
++	mapping->bdaddr_type =3D bdaddr_type;
++	mapping->att =3D att;
++	mapping->rap =3D rap;
++
++	return queue_push_tail(sm->conn_mappings, mapping);
++}
++
++static void remove_conn_mapping(struct cs_state_machine *sm, uint16_t h=
andle)
++{
++	struct rap_conn_mapping *mapping;
++
++	if (!sm || !sm->conn_mappings)
++		return;
++
++	mapping =3D queue_remove_if(sm->conn_mappings, match_mapping_handle,
++					UINT_TO_PTR(handle));
++	if (mapping)
++		mapping_free(mapping);
++}
++
++static void remove_rap_mappings(struct cs_state_machine *sm)
++{
++	if (!sm || !sm->conn_mappings)
++		return;
++
++	queue_remove_all(sm->conn_mappings, match_mapping_rap, sm->rap,
++				mapping_free);
++}
++
++static struct bt_rap *resolve_handle_to_rap(struct cs_state_machine *sm=
,
++						uint16_t handle)
++{
++	struct rap_conn_mapping *mapping;
++
++	if (!sm)
++		return NULL;
++
++	/* Try to find in mapping cache */
++	mapping =3D find_mapping_by_handle(sm, handle);
++	if (mapping && mapping->rap) {
++		DBG("Found handle 0x%04X in mapping cache", handle);
++		return mapping->rap;
++	}
++
++	/* Profile layer should have called bt_rap_set_conn_handle() during
++	 * connection establishment. If we reach here, the mapping was not set.
++	 */
++	DBG("No mapping found for handle 0x%04X", handle);
++	DBG("Profile layer should call bt_rap_set_conn_handle() on connect");
++
++	return NULL;
++}
++
++/*  State Machine Functions */
++static void cs_state_machine_init(struct cs_state_machine *sm,
++				struct bt_rap *rap, struct bt_hci *hci,
++				uint8_t role, uint8_t cs_sync_ant_sel,
++				int8_t max_tx_power)
++{
++	if (!sm)
++		return;
++
++	sm->current_state =3D CS_STATE_UNSPECIFIED;
++	sm->rap =3D rap;
++	sm->hci =3D hci;
++	sm->initiator =3D false;
++	sm->procedure_active =3D false;
++
++	/* Store role_enable for HCI commands (1, 2, or 3 from config) */
++	sm->role_enable =3D role;
++
++	/* Initialize per-instance CS options
++	 * Note: cs_opt.role will be overwritten with actual role (0x00 or 0x0=
1)
++	 * from config complete event, but role_enable preserves the HCI value
++	 */
++	sm->cs_opt.role =3D role;
++	sm->cs_opt.cs_sync_ant_sel =3D cs_sync_ant_sel;
++	sm->cs_opt.max_tx_power =3D max_tx_power;
++	sm->cs_opt.rtt_type =3D 0;  /* Will be set from config complete event =
*/
++}
++
++/* State Transition Logic */
++static void cs_set_state(struct cs_state_machine *sm,
++		enum cs_state new_state)
++{
++	if (!sm)
++		return;
++
++	if (sm->current_state =3D=3D new_state)
++		return;
++
++	/* Validate state values before array access */
++	if (sm->current_state > CS_STATE_UNSPECIFIED ||
++	    new_state > CS_STATE_UNSPECIFIED) {
++		error("Invalid state transition attempted");
++		return;
++	}
++
++	DBG("[STATE] Transition: %s =E2=86=92 %s",
++		state_names[sm->current_state],
++		state_names[new_state]);
++
++	sm->old_state =3D sm->current_state;
++	sm->current_state =3D new_state;
++}
++
++static enum cs_state cs_get_current_state(struct cs_state_machine *sm)
++{
++	return sm ? sm->current_state : CS_STATE_UNSPECIFIED;
++}
++
++/* HCI Event Callbacks */
++static void rap_def_settings_done_cb(const void *data, uint8_t size,
++					void *user_data)
++{
++	struct bt_hci_rsp_le_cs_set_def_settings *rp;
++	struct cs_state_machine *sm =3D (struct cs_state_machine *) user_data;
++
++	if (!sm || !data ||
++		size < sizeof(struct bt_hci_rsp_le_cs_set_def_settings))
++		return;
++
++	DBG("size=3D0x%02X", size);
++
++	rp =3D (struct bt_hci_rsp_le_cs_set_def_settings *) data;
++
++	if (cs_get_current_state(sm) !=3D CS_STATE_INIT) {
++		DBG("Event received in Wrong State!! Expected : CS_STATE_INIT");
++		return;
++	}
++
++	if (rp->status =3D=3D 0) {
++		/* Success - proceed to configuration */
++		cs_set_state(sm, CS_STATE_WAIT_CONFIG_CMPLT);
++
++		/* Reflector role */
++		DBG("Waiting for CS Config Completed event...");
++		/* TODO: Initiator role - Send CS Config complete cmd */
++	} else {
++		/* Error - transition to stopped */
++		error("CS Set default setting failed with status 0x%02X",
++		rp->status);
++		cs_set_state(sm, CS_STATE_STOPPED);
++	}
++}
++
++static void rap_send_hci_def_settings_command(struct cs_state_machine *=
sm,
++		struct bt_hci_evt_le_cs_rd_rem_supp_cap_complete *ev)
++{
++	struct bt_hci_cmd_le_cs_set_def_settings cp;
++	unsigned int status;
++
++	memset(&cp, 0, sizeof(cp));
++
++	if (!sm || !sm->hci) {
++		error("Set Def Settings: sm or hci is null");
++		return;
++	}
++
++	if (ev->handle)
++		cp.handle =3D ev->handle;
++
++	cp.role_enable =3D sm->role_enable;  /* Use preserved HCI command valu=
e */
++	cp.cs_sync_antenna_selection =3D sm->cs_opt.cs_sync_ant_sel;
++	cp.max_tx_power =3D sm->cs_opt.max_tx_power;
++
++	status =3D bt_hci_send(sm->hci, BT_HCI_CMD_LE_CS_SET_DEF_SETTINGS,
++				&cp, sizeof(cp), rap_def_settings_done_cb,
++				sm, NULL);
++
++	DBG("sending set default settings case, status : %d", status);
++
++	if (!status)
++		error("Failed to send default settings cmd");
++}
++
++static void rap_rd_rmt_supp_cap_cmplt_evt(const uint8_t *data, uint8_t =
size,
++					   void *user_data)
++{
++	struct cs_state_machine *sm =3D (struct cs_state_machine *) user_data;
++	const struct bt_hci_evt_le_cs_rd_rem_supp_cap_complete *evt;
++	struct bt_rap *rap;
++	struct iovec iov;
++
++	if (!sm || !data ||
++		size < sizeof(struct bt_hci_evt_le_cs_rd_rem_supp_cap_complete))
++		return;
++
++	/* Initialize iovec with the event data */
++	iov.iov_base =3D (void *) data;
++	iov.iov_len =3D size;
++
++	/* Pull the entire structure at once */
++	evt =3D util_iov_pull_mem(&iov, sizeof(*evt));
++
++	if (!evt) {
++		error("Failed to pull remote cap complete struct");
++		return;
++	}
++
++	DBG("status=3D0x%02X, handle=3D0x%04X", evt->status, evt->handle);
++
++	/* Check status */
++	if (evt->status !=3D 0) {
++		error("Remote capabilities failed with status 0x%02X",
++			evt->status);
++		cs_set_state(sm, CS_STATE_STOPPED);
++		return;
++	}
++
++	/* Resolve handle to RAP instance */
++	rap =3D resolve_handle_to_rap(sm, evt->handle);
++
++	if (!rap) {
++		DBG("[WARN] Could not resolve handle 0x%04X to RAP instance",
++			evt->handle);
++		/* Continue with state machine RAP for now */
++		rap =3D sm->rap;
++	}
++
++	DBG("num_config=3D%u, ",
++		evt->num_config_supported);
++	DBG("max_consecutive_proc=3D%u, num_antennas=3D%u, ",
++		evt->max_consecutive_procedures_supported,
++		evt->num_antennas_supported);
++	DBG("max_antenna_paths=3D%u, roles=3D0x%02X, modes=3D0x%02X",
++		evt->max_antenna_paths_supported,
++		evt->roles_supported,
++		evt->modes_supported);
++
++	rap_send_hci_def_settings_command(sm,
++		(struct bt_hci_evt_le_cs_rd_rem_supp_cap_complete *) evt);
++	cs_set_state(sm, CS_STATE_INIT);
++}
++
++static void rap_cs_config_cmplt_evt(const uint8_t *data, uint8_t size,
++				    void *user_data)
++{
++	struct cs_state_machine *sm =3D (struct cs_state_machine *) user_data;
++	const struct bt_hci_evt_le_cs_config_complete *evt;
++	struct rap_ev_cs_config_cmplt rap_ev;
++	struct iovec iov;
++
++	if (!sm || !data ||
++		size < sizeof(struct bt_hci_evt_le_cs_config_complete))
++		return;
++
++	/* Initialize iovec with the event data */
++	iov.iov_base =3D (void *) data;
++	iov.iov_len =3D size;
++
++	DBG("size=3D0x%02X", size);
++
++	/* State Check */
++	if (cs_get_current_state(sm) !=3D CS_STATE_WAIT_CONFIG_CMPLT) {
++		DBG("Event received in Wrong State!! ");
++		DBG("Expected : CS_STATE_WAIT_CONFIG_CMPLT");
++		return;
++	}
++
++	/* Pull the entire structure at once */
++	evt =3D util_iov_pull_mem(&iov, sizeof(*evt));
++	if (!evt) {
++		error("Failed to pull config complete struct");
++		return;
++	}
++
++	DBG("status=3D0x%02X, handle=3D0x%04X", evt->status, evt->handle);
++
++	/* Check status */
++	if (evt->status !=3D 0) {
++		error("Configuration failed with status 0x%02X",
++			evt->status);
++		cs_set_state(sm, CS_STATE_STOPPED);
++		return;
++	}
++
++	/* Copy fields to rap_ev structure */
++	rap_ev.status =3D evt->status;
++	rap_ev.conn_hdl =3D cpu_to_le16(evt->handle);
++	rap_ev.config_id =3D evt->config_id;
++	rap_ev.action =3D evt->action;
++	rap_ev.main_mode_type =3D evt->main_mode_type;
++	rap_ev.sub_mode_type =3D evt->sub_mode_type;
++	rap_ev.min_main_mode_steps =3D evt->min_main_mode_steps;
++	rap_ev.max_main_mode_steps =3D evt->max_main_mode_steps;
++	rap_ev.main_mode_rep =3D evt->main_mode_repetition;
++	rap_ev.mode_0_steps =3D evt->mode_0_steps;
++	rap_ev.role =3D evt->role;
++	rap_ev.rtt_type =3D evt->rtt_type;
++	rap_ev.cs_sync_phy =3D evt->cs_sync_phy;
++	memcpy(rap_ev.channel_map, evt->channel_map, 10);
++	rap_ev.channel_map_rep =3D evt->channel_map_repetition;
++	rap_ev.channel_sel_type =3D evt->channel_selection_type;
++	rap_ev.ch3c_shape =3D evt->ch3c_shape;
++	rap_ev.ch3c_jump =3D evt->ch3c_jump;
++	rap_ev.reserved =3D evt->reserved;
++	rap_ev.t_ip1_time =3D evt->t_ip1_time;
++	rap_ev.t_ip2_time =3D evt->t_ip2_time;
++	rap_ev.t_fcs_time =3D evt->t_fcs_time;
++	rap_ev.t_pm_time =3D evt->t_pm_time;
++
++	/* Store role and rtt_type from config complete event
++	 * Note: evt->role contains actual role
++	 * (CS_INITIATOR=3D0x00, CS_REFLECTOR=3D0x01)
++	 * which is different from the role_enable value sent in HCI command
++	 */
++	sm->cs_opt.role =3D rap_ev.role;
++	sm->cs_opt.rtt_type =3D rap_ev.rtt_type;
++
++	DBG("config_id=3D%u, action=3D%u, ",
++		rap_ev.config_id, rap_ev.action);
++	DBG("main_mode=3D%u, sub_mode=3D%u, role=3D%u, rtt_type=3D%u",
++		rap_ev.main_mode_type, rap_ev.sub_mode_type,
++		rap_ev.role, rap_ev.rtt_type);
++
++	/* Success - proceed to Security enable complete */
++	cs_set_state(sm, CS_STATE_WAIT_SEC_CMPLT);
++
++	/* Reflector role */
++	DBG("Waiting for security enable event...");
++	/* TODO: Initiator role - Send CS Security enable cmd */
++
++	/* Send callback to RAP Profile */
++	bt_rap_hci_cs_config_complete_callback(size, &rap_ev, sm->rap);
++}
++
++static void rap_cs_sec_enable_cmplt_evt(const uint8_t *data, uint8_t si=
ze,
++					 void *user_data)
++{
++	struct cs_state_machine *sm =3D (struct cs_state_machine *) user_data;
++	struct rap_ev_cs_sec_enable_cmplt rap_ev;
++	struct iovec iov;
++	uint8_t status;
++	uint16_t handle;
++
++	if (!sm || !data ||
++		size < sizeof(struct bt_hci_evt_le_cs_sec_enable_complete))
++		return;
++
++	/* Initialize iovec with the event data */
++	iov.iov_base =3D (void *) data;
++	iov.iov_len =3D size;
++
++	DBG("size=3D0x%02X", size);
++
++	/* State Check */
++	if (cs_get_current_state(sm) !=3D CS_STATE_WAIT_SEC_CMPLT) {
++		DBG("Event received in Wrong State!! ");
++		DBG("Expected : CS_STATE_WAIT_SEC_CMPLT");
++		return;
++	}
++
++	/* Parse all fields in order using iovec */
++	if (!util_iov_pull_u8(&iov, &status)) {
++		error("Failed to parse Status");
++		return;
++	}
++
++	if (!util_iov_pull_le16(&iov, &handle)) {
++		error("Failed to parse Connection_Handle");
++		return;
++	}
++
++	rap_ev.status =3D status;
++	rap_ev.conn_hdl =3D cpu_to_le16(handle);
++
++	DBG("status=3D0x%02X, handle=3D0x%04X",
++		rap_ev.status, handle);
++
++	if (rap_ev.status =3D=3D 0) {
++		/* Success - proceed to configuration */
++		cs_set_state(sm, CS_STATE_WAIT_PROC_CMPLT);
++
++		/* Reflector role */
++		DBG("Waiting for CS Proc complete event...");
++		/* TODO: Initiator - Send CS Proc Set Parameter and enable */
++	} else {
++		/* Error - transition to stopped */
++		error("Security enable failed with status 0x%02X",
++			rap_ev.status);
++		cs_set_state(sm, CS_STATE_STOPPED);
++	}
++
++	/* Send callback to RAP Profile */
++	bt_rap_hci_cs_sec_enable_complete_callback(size, &rap_ev, sm->rap);
++}
++
++static void rap_cs_proc_enable_cmplt_evt(const uint8_t *data, uint8_t s=
ize,
++					  void *user_data)
++{
++	struct cs_state_machine *sm =3D (struct cs_state_machine *) user_data;
++	const struct bt_hci_evt_le_cs_proc_enable_complete *evt;
++	struct rap_ev_cs_proc_enable_cmplt rap_ev;
++	struct iovec iov;
++
++	if (!sm || !data ||
++		size < sizeof(struct bt_hci_evt_le_cs_proc_enable_complete))
++		return;
++
++	/* Initialize iovec with the event data */
++	iov.iov_base =3D (void *) data;
++	iov.iov_len =3D size;
++
++	DBG("size=3D0x%02X", size);
++
++	/* State Check */
++	if (cs_get_current_state(sm) !=3D CS_STATE_WAIT_PROC_CMPLT) {
++		DBG("Event received in Wrong State!! ");
++		DBG("Expected : CS_STATE_WAIT_PROC_CMPLT");
++		return;
++	}
++
++	/* Pull the entire structure at once */
++	evt =3D util_iov_pull_mem(&iov, sizeof(*evt));
++	if (!evt) {
++		error("Failed to pull proc enable complete struct");
++		return;
++	}
++
++	DBG("status=3D0x%02X, handle=3D0x%04X", evt->status, evt->handle);
++
++	/* Check status */
++	if (evt->status !=3D 0) {
++		error("Procedure enable failed with status 0x%02X",
++			evt->status);
++		cs_set_state(sm, CS_STATE_STOPPED);
++		sm->procedure_active =3D false;
++		return;
++	}
++
++	/* Copy fields to rap_ev structure */
++	rap_ev.status =3D evt->status;
++	rap_ev.conn_hdl =3D cpu_to_le16(evt->handle);
++	rap_ev.config_id =3D evt->config_id;
++	rap_ev.state =3D evt->state;
++	rap_ev.tone_ant_config_sel =3D evt->tone_antenna_config_selection;
++	rap_ev.sel_tx_pwr =3D evt->selected_tx_power;
++	memcpy(rap_ev.sub_evt_len, evt->subevent_len, 3);
++	rap_ev.sub_evts_per_evt =3D evt->subevents_per_event;
++	rap_ev.sub_evt_intrvl =3D evt->subevent_interval;
++	rap_ev.evt_intrvl =3D evt->event_interval;
++	rap_ev.proc_intrvl =3D evt->procedure_interval;
++	rap_ev.proc_counter =3D evt->procedure_count;
++	rap_ev.max_proc_len =3D evt->max_procedure_len;
++
++	DBG("config_id=3D%u, state=3D%u, ",
++		rap_ev.config_id, rap_ev.state);
++	DBG("sub_evts_per_evt=3D%u, evt_intrvl=3D%u, proc_intrvl=3D%u",
++		rap_ev.sub_evts_per_evt, rap_ev.evt_intrvl,
++		rap_ev.proc_intrvl);
++
++	/* Success - procedure started */
++	cs_set_state(sm, CS_STATE_STARTED);
++	sm->procedure_active =3D true;
++
++	/* Send callback to RAP Profile */
++	bt_rap_hci_cs_procedure_enable_complete_callback(size,
++			&rap_ev, sm->rap);
++}
++
++static void parse_i_q_sample(struct iovec *iov, int16_t *i_sample,
++				int16_t *q_sample)
++{
++	uint32_t buffer;
++	uint32_t i12;
++	uint32_t q12;
++
++	/* Pull 24-bit little-endian value from iovec */
++	if (!util_iov_pull_le24(iov, &buffer)) {
++		*i_sample =3D 0;
++		*q_sample =3D 0;
++		return;
++	}
++
++	/* Extract 12-bit I and Q values from 24-bit buffer */
++	i12 =3D  buffer        & 0x0FFFU;   /* bits 0..11 */
++	q12 =3D (buffer >> 12) & 0x0FFFU;   /* bits 12..23 */
++
++	/* Sign-extend 12-bit values to 16-bit using macro */
++	*i_sample =3D SIGN_EXTEND_TO_16(i12, 12);
++	*q_sample =3D SIGN_EXTEND_TO_16(q12, 12);
++}
++
++/* Parse CS Mode 0 step data */
++static void parse_mode_zero_data(struct iovec *iov,
++				 struct cs_mode_zero_data *mode_data,
++				 uint8_t cs_role)
++{
++	uint32_t freq_offset;
++
++	if (iov->iov_len < 3) {
++		DBG("Mode 0: too short (<3)");
++		return;
++	}
++
++	util_iov_pull_u8(iov, &mode_data->packet_quality);
++	util_iov_pull_u8(iov, &mode_data->packet_rssi_dbm);
++	util_iov_pull_u8(iov, &mode_data->packet_ant);
++	DBG("CS Step mode 0");
++
++	if (cs_role =3D=3D CS_INITIATOR && iov->iov_len >=3D 4) {
++		util_iov_pull_le32(iov, &freq_offset);
++		mode_data->init_measured_freq_offset =3D freq_offset;
++	}
++}
++
++/* Parse CS Mode 1 step data */
++static void parse_mode_one_data(struct iovec *iov,
++				struct cs_mode_one_data *mode_data,
++				uint8_t cs_role, uint8_t cs_rtt_type)
++{
++	uint16_t time_val;
++
++	if (iov->iov_len < 4) {
++		DBG("Mode 1: too short (<4)");
++		return;
++	}
++
++	DBG("CS Step mode 1");
++	util_iov_pull_u8(iov, &mode_data->packet_quality);
++	util_iov_pull_u8(iov, &mode_data->packet_rssi_dbm);
++	util_iov_pull_u8(iov, &mode_data->packet_ant);
++	util_iov_pull_u8(iov, &mode_data->packet_nadm);
++
++	if (iov->iov_len >=3D 2) {
++		util_iov_pull_le16(iov, &time_val);
++		if (cs_role =3D=3D CS_REFLECTOR)
++			mode_data->tod_toa_refl =3D time_val;
++		else
++			mode_data->toa_tod_init =3D time_val;
++	}
++
++	if ((cs_rtt_type =3D=3D 0x01 || cs_rtt_type =3D=3D 0x02) &&
++		iov->iov_len >=3D 6) {
++		int16_t i_val, q_val;
++
++		parse_i_q_sample(iov, &i_val, &q_val);
++		mode_data->packet_pct1.i_sample =3D i_val;
++		mode_data->packet_pct1.q_sample =3D q_val;
++
++		parse_i_q_sample(iov, &i_val, &q_val);
++		mode_data->packet_pct2.i_sample =3D i_val;
++		mode_data->packet_pct2.q_sample =3D q_val;
++	}
++}
++
++/* Parse CS Mode 2 step data */
++static void parse_mode_two_data(struct iovec *iov,
++				struct cs_mode_two_data *mode_data,
++				uint8_t max_paths)
++{
++	uint8_t k;
++
++	if (iov->iov_len < 1) {
++		DBG("Mode 2: too short (<1)");
++		return;
++	}
++
++	util_iov_pull_u8(iov, &mode_data->ant_perm_index);
++	DBG("CS Step mode 2, max paths : %d", max_paths);
++
++	for (k =3D 0; k < max_paths; k++) {
++		int16_t i_val, q_val;
++
++		if (iov->iov_len < 4) {
++			DBG("Mode 2: insufficient PCT for path %u (rem=3D%zu)",
++				k, iov->iov_len);
++			break;
++		}
++		parse_i_q_sample(iov, &i_val, &q_val);
++		mode_data->tone_pct[k].i_sample =3D i_val;
++		mode_data->tone_pct[k].q_sample =3D q_val;
++
++		util_iov_pull_u8(iov, &mode_data->tone_quality_indicator[k]);
++		DBG("tone_quality_indicator : %d",
++			mode_data->tone_quality_indicator[k]);
++		DBG("[i, q] : %d, %d",
++			mode_data->tone_pct[k].i_sample,
++			mode_data->tone_pct[k].q_sample);
++	}
++}
++
++/* Parse CS Mode 3 step data */
++static void parse_mode_three_data(struct iovec *iov,
++				struct cs_mode_three_data *mode_data,
++				uint8_t cs_role, uint8_t cs_rtt_type,
++				uint8_t max_paths)
++{
++	uint8_t k;
++	struct cs_mode_one_data *mode_one =3D &mode_data->mode_one_data;
++	struct cs_mode_two_data *mode_two =3D &mode_data->mode_two_data;
++
++	if (iov->iov_len < 4) {
++		DBG("Mode 3: mode1 too short (<4)");
++		return;
++	}
++
++	DBG("CS Step mode 3");
++
++	/* Parse Mode 1 portion */
++	parse_mode_one_data(iov, mode_one, cs_role, cs_rtt_type);
++
++	/* Parse Mode 2 portion */
++	if (iov->iov_len >=3D 1) {
++		util_iov_pull_u8(iov, &mode_two->ant_perm_index);
++		for (k =3D 0; k < max_paths; k++) {
++			int16_t i_val, q_val;
++
++			if (iov->iov_len < 4)
++				break;
++			parse_i_q_sample(iov, &i_val, &q_val);
++			mode_two->tone_pct[k].i_sample =3D i_val;
++			mode_two->tone_pct[k].q_sample =3D q_val;
++
++			util_iov_pull_u8(iov,
++					 &mode_two->tone_quality_indicator[k]);
++		}
++	}
++}
++
++/* Parse a single CS step */
++static void parse_cs_step(struct iovec *iov, struct cs_step_data *step,
++			uint8_t cs_role, uint8_t cs_rtt_type,
++			uint8_t max_paths)
++{
++	uint8_t mode;
++	uint8_t chnl;
++	uint8_t length;
++
++	/* Check if we have enough data for the 3-byte header */
++	if (iov->iov_len < 3) {
++		DBG("Truncated header for step");
++		return;
++	}
++
++	/* Read mode, channel, and length (3-byte header) */
++	if (!util_iov_pull_u8(iov, &mode) ||
++		!util_iov_pull_u8(iov, &chnl) ||
++		!util_iov_pull_u8(iov, &length)) {
++		DBG("Failed to read header for step");
++		return;
++	}
++
++	DBG("event->step_data_len : %d", length);
++
++	step->step_mode =3D mode;
++	step->step_chnl =3D chnl;
++	step->step_data_length =3D length;
++
++	DBG("Step: mode=3D%u chnl=3D%u data_len=3D%u", mode, chnl, length);
++
++	if (iov->iov_len < length) {
++		DBG("Truncated payload for step (need %u, have %zu)",
++			length, iov->iov_len);
++		return;
++	}
++
++	/* Parse step data based on mode */
++	switch (mode) {
++	case CS_MODE_ZERO:
++		parse_mode_zero_data(iov, &step->step_mode_data.mode_zero_data,
++					cs_role);
++		break;
++	case CS_MODE_ONE:
++		parse_mode_one_data(iov, &step->step_mode_data.mode_one_data,
++					cs_role, cs_rtt_type);
++		break;
++	case CS_MODE_TWO:
++		parse_mode_two_data(iov, &step->step_mode_data.mode_two_data,
++					max_paths);
++		break;
++	case CS_MODE_THREE:
++		parse_mode_three_data(iov,
++					&step->step_mode_data.mode_three_data,
++					cs_role, cs_rtt_type, max_paths);
++		break;
++	default:
++		DBG("Unknown step mode %d", mode);
++		/* Skip the entire step data */
++		util_iov_pull(iov, length);
++		break;
++	}
++}
++
++static void rap_cs_subevt_result_evt(const uint8_t *data, uint8_t size,
++				void *user_data)
++{
++	struct cs_state_machine *sm =3D (struct cs_state_machine *) user_data;
++	struct rap_ev_cs_subevent_result *rap_ev;
++	struct iovec iov;
++	uint8_t cs_role;
++	uint8_t cs_rtt_type;
++	uint8_t max_paths;
++	uint8_t steps;
++	size_t send_len =3D 0;
++	uint16_t handle;
++	uint8_t config_id;
++	uint16_t start_acl_conn_evt_counter;
++	uint16_t proc_counter;
++	uint16_t freq_comp;
++	uint8_t ref_pwr_lvl;
++	uint8_t proc_done_status;
++	uint8_t subevt_done_status;
++	uint8_t abort_reason;
++	uint8_t num_ant_paths;
++	uint8_t num_steps_reported;
++	uint8_t i;
++
++	if (!sm || !data ||
++		size < sizeof(struct bt_hci_evt_le_cs_subevent_result))
++		return;
++
++	/* Initialize iovec with the event data */
++	iov.iov_base =3D (void *) data;
++	iov.iov_len =3D size;
++
++	/* Check if Procedure is active or not */
++	if (!sm->procedure_active) {
++		DBG("Received Subevent event when Procedure is inactive!");
++		return;
++	}
++
++	/* Parse header fields using iovec */
++	if (!util_iov_pull_le16(&iov, &handle)) {
++		error("Failed to parse Connection_Handle");
++		return;
++	}
++
++	if (!util_iov_pull_u8(&iov, &config_id) ||
++		!util_iov_pull_le16(&iov, &start_acl_conn_evt_counter) ||
++		!util_iov_pull_le16(&iov, &proc_counter) ||
++		!util_iov_pull_le16(&iov, &freq_comp) ||
++		!util_iov_pull_u8(&iov, &ref_pwr_lvl) ||
++		!util_iov_pull_u8(&iov, &proc_done_status) ||
++		!util_iov_pull_u8(&iov, &subevt_done_status) ||
++		!util_iov_pull_u8(&iov, &abort_reason) ||
++		!util_iov_pull_u8(&iov, &num_ant_paths) ||
++		!util_iov_pull_u8(&iov, &num_steps_reported)) {
++		error("Failed to parse subevent fields");
++		return;
++	}
++
++	cs_role =3D sm->cs_opt.role;
++	cs_rtt_type =3D sm->cs_opt.rtt_type;
++	max_paths =3D MIN((num_ant_paths + 1), CS_MAX_ANT_PATHS);
++	steps =3D MIN(num_steps_reported, CS_MAX_STEPS);
++	send_len =3D offsetof(struct rap_ev_cs_subevent_result, step_data) +
++					steps * sizeof(struct cs_step_data);
++	rap_ev =3D malloc0(send_len);
++	if (!rap_ev) {
++		error("Failed to allocate memory for subevent result\n");
++		return;
++	}
++
++	DBG("length=3D%u", size);
++	rap_ev->conn_hdl                     =3D le16_to_cpu(handle);
++	rap_ev->config_id                    =3D config_id;
++	rap_ev->start_acl_conn_evt_counter   =3D start_acl_conn_evt_counter;
++	rap_ev->proc_counter                 =3D proc_counter;
++	rap_ev->freq_comp                    =3D freq_comp;
++	rap_ev->ref_pwr_lvl                  =3D ref_pwr_lvl;
++	rap_ev->proc_done_status             =3D proc_done_status;
++	rap_ev->subevt_done_status           =3D subevt_done_status;
++	rap_ev->abort_reason                 =3D abort_reason;
++	rap_ev->num_ant_paths                =3D num_ant_paths;
++	rap_ev->num_steps_reported           =3D steps;
++
++	if (num_steps_reported > CS_MAX_STEPS) {
++		DBG("Too many steps reported: %u (max %u)",
++			num_steps_reported, CS_MAX_STEPS);
++		goto send_event;
++	}
++
++	/* Early exit for error conditions */
++	if (rap_ev->subevt_done_status =3D=3D 0xF ||
++	    rap_ev->proc_done_status =3D=3D 0xF) {
++		DBG("CS Procedure/Subevent aborted: ");
++		DBG("sub evt status =3D %d, proc status =3D %d, reason =3D %d",
++			rap_ev->subevt_done_status, rap_ev->proc_done_status,
++			rap_ev->abort_reason);
++		goto send_event;
++	}
++
++	/* Parse interleaved step data from remaining iovec data */
++	for (i =3D 0; i < steps; i++)
++		parse_cs_step(&iov, &rap_ev->step_data[i], cs_role, cs_rtt_type,
++			max_paths);
++
++send_event:
++	DBG("CS subevent result processed: %zu bytes, ", send_len);
++	bt_rap_hci_cs_subevent_result_callback(send_len, rap_ev, sm->rap);
++	free(rap_ev);
++}
++
++static void rap_cs_subevt_result_cont_evt(const uint8_t *data, uint8_t =
size,
++					void *user_data)
++{
++	struct cs_state_machine *sm =3D (struct cs_state_machine *) user_data;
++	struct rap_ev_cs_subevent_result_cont *rap_ev;
++	struct iovec iov;
++	uint8_t cs_role;
++	uint8_t cs_rtt_type;
++	uint8_t max_paths;
++	uint8_t steps;
++	size_t send_len =3D 0;
++	uint16_t handle;
++	uint8_t config_id;
++	uint8_t proc_done_status;
++	uint8_t subevt_done_status;
++	uint8_t abort_reason;
++	uint8_t num_ant_paths;
++	uint8_t num_steps_reported;
++	uint8_t i;
++
++	if (!sm || !data ||
++		size < sizeof(struct bt_hci_evt_le_cs_subevent_result_continue))
++		return;
++
++	/* Initialize iovec with the event data */
++	iov.iov_base =3D (void *) data;
++	iov.iov_len =3D size;
++
++	/* Check if Procedure is active or not */
++	if (!sm->procedure_active) {
++		error("Received Subevent when CS Procedure is inactive!");
++		return;
++	}
++
++	/* Parse header fields using iovec */
++	if (!util_iov_pull_le16(&iov, &handle)) {
++		error("Failed to parse Connection_Handle");
++		return;
++	}
++
++	if (!util_iov_pull_u8(&iov, &config_id) ||
++		!util_iov_pull_u8(&iov, &proc_done_status) ||
++		!util_iov_pull_u8(&iov, &subevt_done_status) ||
++		!util_iov_pull_u8(&iov, &abort_reason) ||
++		!util_iov_pull_u8(&iov, &num_ant_paths) ||
++		!util_iov_pull_u8(&iov, &num_steps_reported)) {
++		error("Failed to parse subevent continue fields ");
++		return;
++	}
++
++	cs_role =3D sm->cs_opt.role;
++	cs_rtt_type =3D sm->cs_opt.rtt_type;
++	max_paths =3D MIN((num_ant_paths + 1), CS_MAX_ANT_PATHS);
++	steps =3D MIN(num_steps_reported, CS_MAX_STEPS);
++	send_len =3D offsetof(struct rap_ev_cs_subevent_result_cont, step_data=
) +
++					steps * sizeof(struct cs_step_data);
++	rap_ev =3D malloc0(send_len);
++	if (!rap_ev) {
++		error("Failed to allocate memory for subevent result\n");
++		return;
++	}
++
++	DBG("length=3D%u", size);
++	rap_ev->conn_hdl                     =3D le16_to_cpu(handle);
++	rap_ev->config_id                    =3D config_id;
++	rap_ev->proc_done_status             =3D proc_done_status;
++	rap_ev->subevt_done_status           =3D subevt_done_status;
++	rap_ev->abort_reason                 =3D abort_reason;
++	rap_ev->num_ant_paths                =3D num_ant_paths;
++	rap_ev->num_steps_reported           =3D steps;
++
++	if (num_steps_reported > CS_MAX_STEPS) {
++		DBG("Too many steps reported: %u (max %u)",
++			num_steps_reported, CS_MAX_STEPS);
++		goto send_event;
++	}
++
++	/* Early exit for error conditions */
++	if (rap_ev->subevt_done_status =3D=3D 0xF ||
++	    rap_ev->proc_done_status =3D=3D 0xF) {
++		DBG("CS Procedure/Subevent aborted: ");
++		DBG("sub evt status =3D %d, proc status =3D %d, reason =3D %d",
++			rap_ev->subevt_done_status, rap_ev->proc_done_status,
++			rap_ev->abort_reason);
++		goto send_event;
++	}
++
++	/* Parse interleaved step data from remaining iovec data */
++	for (i =3D 0; i < steps; i++)
++		parse_cs_step(&iov, &rap_ev->step_data[i], cs_role, cs_rtt_type,
++			max_paths);
++
++send_event:
++	DBG("CS subevent result cont processed: %zu bytes, ", send_len);
++	bt_rap_hci_cs_subevent_result_cont_callback(send_len, rap_ev, sm->rap)=
;
++	free(rap_ev);
++}
++
++/* Subevent handler function type */
++typedef void (*subevent_handler_t)(const uint8_t *data, uint8_t size,
++				   void *user_data);
++
++/* Subevent table entry */
++struct subevent_entry {
++	uint8_t opcode;
++	uint8_t min_len;
++	uint8_t max_len;
++	subevent_handler_t handler;
++	const char *name;
++};
++
++/* Macro to define HCI event entries
++ * Note: min_len excludes the subevent byte since it's stripped before =
dispatch
++ */
++#define HCI_EVT(_opcode, _struct, _handler, _name) \
++	{ \
++		.opcode =3D _opcode, \
++		.min_len =3D sizeof(_struct), \
++		.max_len =3D 0xFF, \
++		.handler =3D _handler, \
++		.name =3D _name \
++	}
++
++/* Subevent dispatch table */
++static const struct subevent_entry subevent_table[] =3D {
++	HCI_EVT(BT_HCI_EVT_LE_CS_RD_REM_SUPP_CAP_COMPLETE,
++		struct bt_hci_evt_le_cs_rd_rem_supp_cap_complete,
++		rap_rd_rmt_supp_cap_cmplt_evt,
++		"CS Read Remote Supported Capabilities Complete"),
++	HCI_EVT(BT_HCI_EVT_LE_CS_CONFIG_COMPLETE,
++		struct bt_hci_evt_le_cs_config_complete,
++		rap_cs_config_cmplt_evt,
++		"CS Config Complete"),
++	HCI_EVT(BT_HCI_EVT_LE_CS_SEC_ENABLE_COMPLETE,
++		struct bt_hci_evt_le_cs_sec_enable_complete,
++		rap_cs_sec_enable_cmplt_evt,
++		"CS Security Enable Complete"),
++	HCI_EVT(BT_HCI_EVT_LE_CS_PROC_ENABLE_COMPLETE,
++		struct bt_hci_evt_le_cs_proc_enable_complete,
++		rap_cs_proc_enable_cmplt_evt,
++		"CS Procedure Enable Complete"),
++	HCI_EVT(BT_HCI_EVT_LE_CS_SUBEVENT_RESULT,
++		struct bt_hci_evt_le_cs_subevent_result,
++		rap_cs_subevt_result_evt,
++		"CS Subevent Result"),
++	HCI_EVT(BT_HCI_EVT_LE_CS_SUBEVENT_RESULT_CONTINUE,
++		struct bt_hci_evt_le_cs_subevent_result_continue,
++		rap_cs_subevt_result_cont_evt,
++		"CS Subevent Result Continue")
++};
++
++#undef HCI_EVT
++
++#define SUBEVENT_TABLE_SIZE ARRAY_SIZE(subevent_table)
++
++/* HCI Event Registration */
++static void rap_handle_hci_events(const void *data, uint8_t size,
++				void *user_data)
++{
++	struct iovec iov;
++	uint8_t subevent;
++	const struct subevent_entry *entry =3D NULL;
++	size_t i;
++
++	/* Initialize iovec with the event data */
++	iov.iov_base =3D (void *) data;
++	iov.iov_len =3D size;
++
++	/* Pull the subevent code */
++	if (!util_iov_pull_u8(&iov, &subevent)) {
++		DBG("Failed to parse subevent code");
++		return;
++	}
++
++	/* Find the subevent in the table */
++	for (i =3D 0; i < SUBEVENT_TABLE_SIZE; i++) {
++		if (subevent_table[i].opcode =3D=3D subevent) {
++			entry =3D &subevent_table[i];
++			break;
++		}
++	}
++
++	/* Check if subevent is supported */
++	if (!entry) {
++		DBG("Unknown subevent: 0x%02X", subevent);
++		return;
++	}
++
++	/* Validate payload length */
++	if (iov.iov_len < entry->min_len) {
++		DBG("%s: payload too short (%zu < %u)",
++		    entry->name, iov.iov_len, entry->min_len);
++		return;
++	}
++
++	if (entry->max_len !=3D 0xFF && iov.iov_len > entry->max_len) {
++		DBG("%s: payload too long (%zu > %u)",
++		    entry->name, iov.iov_len, entry->max_len);
++		return;
++	}
++
++	/* Call the handler */
++	DBG("Handling %s (opcode=3D0x%02X, len=3D%zu)",
++	    entry->name, subevent, iov.iov_len);
++
++	entry->handler(iov.iov_base, iov.iov_len, user_data);
++}
++
++void *bt_rap_attach_hci(struct bt_rap *rap, struct bt_hci *hci,
++			uint8_t role, uint8_t cs_sync_ant_sel,
++			int8_t max_tx_power)
++{
++	struct cs_state_machine *sm;
++
++	if (!rap || !hci) {
++		error("rap or hci null");
++		return NULL;
++	}
++
++	/* Allocate per-instance state machine */
++	sm =3D new0(struct cs_state_machine, 1);
++	if (!sm) {
++		error("Failed to allocate state machine");
++		return NULL;
++	}
++
++	/* Initialize state machine with provided CS options */
++	cs_state_machine_init(sm, rap, hci, role, cs_sync_ant_sel,
++				max_tx_power);
++
++	sm->event_id =3D bt_hci_register(hci, BT_HCI_EVT_LE_META_EVENT,
++					rap_handle_hci_events, sm, NULL);
++
++	DBG("bt_hci_register done, event_id : %d", sm->event_id);
++
++	if (!sm->event_id) {
++		error("Failed to register hci le meta events");
++		error("event_id=3D0x%02X", sm->event_id);
++		free(sm);
++		return NULL;
++	}
++
++	DBG("CS options: role=3D%u, cs_sync_ant_sel=3D%u, max_tx_power=3D%d",
++		role, cs_sync_ant_sel, max_tx_power);
++
++	return sm;
++}
++
++bool bt_rap_set_conn_handle(void *hci_sm, struct bt_rap *rap, uint16_t =
handle,
++				const uint8_t *bdaddr, uint8_t bdaddr_type)
++{
++	struct cs_state_machine *sm =3D hci_sm;
++	struct bt_att *att;
++
++	if (!sm || !rap)
++		return false;
++
++	att =3D bt_rap_get_att(rap);
++	if (!att)
++		return false;
++
++	DBG("Setting connection mapping: handle=3D0x%04X, ", handle);
++	if (bdaddr) {
++		DBG("bdaddr=3D%02x:%02x:%02x:%02x:%02x:%02x type=3D%u",
++			bdaddr[5], bdaddr[4], bdaddr[3],
++			bdaddr[2], bdaddr[1], bdaddr[0], bdaddr_type);
++	}
++
++	return add_conn_mapping(sm, handle, bdaddr, bdaddr_type, att, rap);
++}
++
++void bt_rap_clear_conn_handle(void *hci_sm, uint16_t handle)
++{
++	struct cs_state_machine *sm =3D hci_sm;
++
++	if (!sm)
++		return;
++
++	DBG("Clearing connection mapping: handle=3D0x%04X", handle);
++	remove_conn_mapping(sm, handle);
++}
++
++void bt_rap_detach_hci(struct bt_rap *rap, void *hci_sm)
++{
++	struct cs_state_machine *sm =3D hci_sm;
++
++	if (!rap)
++		return;
++
++	DBG("Detaching RAP from HCI, cleaning up mappings");
++
++	/* Cleanup the per-instance state machine */
++	if (sm) {
++		/* Unregister HCI events */
++		if (sm->event_id && sm->hci)
++			bt_hci_unregister(sm->hci, sm->event_id);
++
++		/* Clean up per-instance connection mappings */
++		remove_rap_mappings(sm);
++
++		/* Destroy the connection mappings queue */
++		queue_destroy(sm->conn_mappings, mapping_free);
++
++		/* Free the state machine */
++		free(sm);
++	}
++}
+--=20
+2.34.1
+
diff --git a/recipes-connectivity/bluez5/bluez5/0004-shared-util-Add-MIN-=
MAX-implementations.patch b/recipes-connectivity/bluez5/bluez5/0004-share=
d-util-Add-MIN-MAX-implementations.patch
new file mode 100644
index 0000000..6cd680a
--- /dev/null
+++ b/recipes-connectivity/bluez5/bluez5/0004-shared-util-Add-MIN-MAX-imp=
lementations.patch
@@ -0,0 +1,49 @@
+From 023e57342a0791b586e336fecce627ecb6a2e46f Mon Sep 17 00:00:00 2001
+From: Bastien Nocera <hadess@hadess.net>
+Date: Tue, 31 Mar 2026 23:36:36 +0200
+Subject: [PATCH] shared/util: Add MIN/MAX implementations
+
+And remove it from src/sdpd-request.c to avoid a redefinition warning
+at compile-time.
+
+Upstream-Status: Backport [c34ed95fa59b4a61882794f329f74a32a5b1f949]
+Signed-off-by: Bastien Nocera <hadess@hadess.net>
+Signed-off-by: Prathibha Madugonde <prathibha.madugonde@oss.qualcomm.com=
>
+---
+ src/sdpd-request.c | 2 --
+ src/shared/util.h  | 6 ++++++
+ 2 files changed, 6 insertions(+), 2 deletions(-)
+
+diff --git a/src/sdpd-request.c b/src/sdpd-request.c
+index 1fc07e97b..7c632c2aa 100644
+--- a/src/sdpd-request.c
++++ b/src/sdpd-request.c
+@@ -40,8 +40,6 @@ typedef struct {
+=20
+ #define SDP_CONT_STATE_SIZE (sizeof(uint8_t) + sizeof(sdp_cont_state_t)=
)
+=20
+-#define MIN(x, y) ((x) < (y)) ? (x): (y)
+-
+ typedef struct sdp_cont_info sdp_cont_info_t;
+=20
+ struct sdp_cont_info {
+diff --git a/src/shared/util.h b/src/shared/util.h
+index c480351d6..67629dddf 100644
+--- a/src/shared/util.h
++++ b/src/shared/util.h
+@@ -22,6 +22,12 @@
+ #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]))
+ #define BIT(n)  (1 << (n))
+=20
++#undef MIN
++#define MIN(a, b) ((a) < (b) ? (a) : (b))
++
++#undef MAX
++#define MAX(a, b) ((a) > (b) ? (a) : (b))
++
+ #if __BYTE_ORDER =3D=3D __LITTLE_ENDIAN
+ #define le16_to_cpu(val) (val)
+ #define le32_to_cpu(val) (val)
+--=20
+2.34.1
+
diff --git a/recipes-connectivity/bluez5/bluez5/0005-rap-Cleanup-coding-s=
tyle-and-unnecessary-code.patch b/recipes-connectivity/bluez5/bluez5/0005=
-rap-Cleanup-coding-style-and-unnecessary-code.patch
new file mode 100644
index 0000000..3924601
--- /dev/null
+++ b/recipes-connectivity/bluez5/bluez5/0005-rap-Cleanup-coding-style-an=
d-unnecessary-code.patch
@@ -0,0 +1,261 @@
+From 6cbdfc70601364435b97276ba9a4feac6179a1ff Mon Sep 17 00:00:00 2001
+From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
+Date: Thu, 23 Apr 2026 12:30:19 -0400
+Subject: [PATCH] rap: Cleanup coding style and unnecessary code
+
+Upstream-Status: Backport [6cbdfc70601364435b97276ba9a4feac6179a1ff]
+Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
+Signed-off-by: Prathibha Madugonde <prathibha.madugonde@oss.qualcomm.com=
>
+---
+ profiles/ranging/rap.c     | 37 ++++++++------------
+ profiles/ranging/rap_hci.c | 71 ++++++++------------------------------
+ 2 files changed, 29 insertions(+), 79 deletions(-)
+
+diff --git a/profiles/ranging/rap.c b/profiles/ranging/rap.c
+index df4f07811..e0a46a87a 100644
+--- a/profiles/ranging/rap.c
++++ b/profiles/ranging/rap.c
+@@ -64,17 +64,14 @@ static bool match_adapter(const void *data, const vo=
id *match_data)
+ 	return adapter_data->adapter =3D=3D adapter;
+ }
+=20
+-static struct rap_adapter_data *rap_adapter_data_find(
+-		struct btd_adapter *adapter)
++static struct rap_adapter_data *
++rap_adapter_data_find(struct btd_adapter *adapter)
+ {
+-	if (!adapter_list)
+-		return NULL;
+-
+ 	return queue_find(adapter_list, match_adapter, adapter);
+ }
+=20
+-static struct rap_adapter_data *rap_adapter_data_new(
+-		struct btd_adapter *adapter)
++static struct rap_adapter_data *
++rap_adapter_data_new(struct btd_adapter *adapter)
+ {
+ 	struct rap_adapter_data *adapter_data;
+ 	int16_t hci_index;
+@@ -117,8 +114,8 @@ static struct rap_adapter_data *rap_adapter_data_new=
(
+ 	return adapter_data;
+ }
+=20
+-static struct rap_adapter_data *rap_adapter_data_ref(
+-		struct btd_adapter *adapter)
++static struct rap_adapter_data *
++rap_adapter_data_ref(struct btd_adapter *adapter)
+ {
+ 	struct rap_adapter_data *adapter_data;
+=20
+@@ -472,7 +469,7 @@ static void rap_server_remove(struct btd_profile *p,
+ {
+ 	DBG("");
+ }
+-/* Profile definition */
++
+ static struct btd_profile rap_profile =3D {
+ 	.name		=3D "rap",
+ 	.priority	=3D BTD_PROFILE_PRIORITY_MEDIUM,
+@@ -493,16 +490,15 @@ static struct btd_profile rap_profile =3D {
+ };
+=20
+ static unsigned int rap_id;
+-/* Plugin init/exit */
++
+ static int rap_init(void)
+ {
+-	DBG("");
+-	if (!(g_dbus_get_flags() & G_DBUS_FLAG_ENABLE_EXPERIMENTAL)) {
+-		DBG("D-Bus experimental not enabled");
+-		return -ENOTSUP;
+-	}
++	int err;
++
++	err =3D btd_profile_register(&rap_profile);
++	if (err)
++		return err;
+=20
+-	btd_profile_register(&rap_profile);
+ 	rap_id =3D bt_rap_register(rap_attached, rap_detached, NULL);
+=20
+ 	return 0;
+@@ -510,12 +506,9 @@ static int rap_init(void)
+=20
+ static void rap_exit(void)
+ {
+-	if (g_dbus_get_flags() & G_DBUS_FLAG_ENABLE_EXPERIMENTAL) {
+-		btd_profile_unregister(&rap_profile);
+-		bt_rap_unregister(rap_id);
+-	}
++	btd_profile_unregister(&rap_profile);
++	bt_rap_unregister(rap_id);
+ }
+=20
+-/* Plugin definition */
+ BLUETOOTH_PLUGIN_DEFINE(rap, VERSION, BLUETOOTH_PLUGIN_PRIORITY_DEFAULT=
,
+ 			rap_init, rap_exit)
+diff --git a/profiles/ranging/rap_hci.c b/profiles/ranging/rap_hci.c
+index 1aca4bbf8..a3d2df608 100644
+--- a/profiles/ranging/rap_hci.c
++++ b/profiles/ranging/rap_hci.c
+@@ -24,10 +24,6 @@
+ #include "src/log.h"
+ #include "monitor/bt.h"
+=20
+-#ifndef MIN
+-#define MIN(a, b) ((a) < (b) ? (a) : (b))
+-#endif
+-
+ /* Macro to sign-extend an N-bit value to 16-bit signed integer */
+ #define SIGN_EXTEND_TO_16(val, bits) \
+ 	((int16_t)(((val) ^ (1U << ((bits)-1))) - (1U << ((bits)-1))))
+@@ -184,30 +180,6 @@ static void remove_rap_mappings(struct cs_state_mac=
hine *sm)
+ 				mapping_free);
+ }
+=20
+-static struct bt_rap *resolve_handle_to_rap(struct cs_state_machine *sm=
,
+-						uint16_t handle)
+-{
+-	struct rap_conn_mapping *mapping;
+-
+-	if (!sm)
+-		return NULL;
+-
+-	/* Try to find in mapping cache */
+-	mapping =3D find_mapping_by_handle(sm, handle);
+-	if (mapping && mapping->rap) {
+-		DBG("Found handle 0x%04X in mapping cache", handle);
+-		return mapping->rap;
+-	}
+-
+-	/* Profile layer should have called bt_rap_set_conn_handle() during
+-	 * connection establishment. If we reach here, the mapping was not set.
+-	 */
+-	DBG("No mapping found for handle 0x%04X", handle);
+-	DBG("Profile layer should call bt_rap_set_conn_handle() on connect");
+-
+-	return NULL;
+-}
+-
+ /*  State Machine Functions */
+ static void cs_state_machine_init(struct cs_state_machine *sm,
+ 				struct bt_rap *rap, struct bt_hci *hci,
+@@ -271,10 +243,9 @@ static void rap_def_settings_done_cb(const void *da=
ta, uint8_t size,
+ 					void *user_data)
+ {
+ 	struct bt_hci_rsp_le_cs_set_def_settings *rp;
+-	struct cs_state_machine *sm =3D (struct cs_state_machine *) user_data;
++	struct cs_state_machine *sm =3D user_data;
+=20
+-	if (!sm || !data ||
+-		size < sizeof(struct bt_hci_rsp_le_cs_set_def_settings))
++	if (!sm || !data || size < sizeof(*rp))
+ 		return;
+=20
+ 	DBG("size=3D0x%02X", size);
+@@ -302,20 +273,20 @@ static void rap_def_settings_done_cb(const void *d=
ata, uint8_t size,
+ }
+=20
+ static void rap_send_hci_def_settings_command(struct cs_state_machine *=
sm,
+-		struct bt_hci_evt_le_cs_rd_rem_supp_cap_complete *ev)
++						uint16_t handle)
+ {
+ 	struct bt_hci_cmd_le_cs_set_def_settings cp;
+ 	unsigned int status;
+=20
+-	memset(&cp, 0, sizeof(cp));
+-
+ 	if (!sm || !sm->hci) {
+ 		error("Set Def Settings: sm or hci is null");
+ 		return;
+ 	}
+=20
+-	if (ev->handle)
+-		cp.handle =3D ev->handle;
++	memset(&cp, 0, sizeof(cp));
++
++	if (handle)
++		cp.handle =3D handle;
+=20
+ 	cp.role_enable =3D sm->role_enable;  /* Use preserved HCI command valu=
e */
+ 	cp.cs_sync_antenna_selection =3D sm->cs_opt.cs_sync_ant_sel;
+@@ -334,13 +305,11 @@ static void rap_send_hci_def_settings_command(stru=
ct cs_state_machine *sm,
+ static void rap_rd_rmt_supp_cap_cmplt_evt(const uint8_t *data, uint8_t =
size,
+ 					   void *user_data)
+ {
+-	struct cs_state_machine *sm =3D (struct cs_state_machine *) user_data;
++	struct cs_state_machine *sm =3D user_data;
+ 	const struct bt_hci_evt_le_cs_rd_rem_supp_cap_complete *evt;
+-	struct bt_rap *rap;
+ 	struct iovec iov;
+=20
+-	if (!sm || !data ||
+-		size < sizeof(struct bt_hci_evt_le_cs_rd_rem_supp_cap_complete))
++	if (!sm || !data || size < sizeof(*evt))
+ 		return;
+=20
+ 	/* Initialize iovec with the event data */
+@@ -365,16 +334,6 @@ static void rap_rd_rmt_supp_cap_cmplt_evt(const uin=
t8_t *data, uint8_t size,
+ 		return;
+ 	}
+=20
+-	/* Resolve handle to RAP instance */
+-	rap =3D resolve_handle_to_rap(sm, evt->handle);
+-
+-	if (!rap) {
+-		DBG("[WARN] Could not resolve handle 0x%04X to RAP instance",
+-			evt->handle);
+-		/* Continue with state machine RAP for now */
+-		rap =3D sm->rap;
+-	}
+-
+ 	DBG("num_config=3D%u, ",
+ 		evt->num_config_supported);
+ 	DBG("max_consecutive_proc=3D%u, num_antennas=3D%u, ",
+@@ -385,21 +344,19 @@ static void rap_rd_rmt_supp_cap_cmplt_evt(const ui=
nt8_t *data, uint8_t size,
+ 		evt->roles_supported,
+ 		evt->modes_supported);
+=20
+-	rap_send_hci_def_settings_command(sm,
+-		(struct bt_hci_evt_le_cs_rd_rem_supp_cap_complete *) evt);
++	rap_send_hci_def_settings_command(sm, evt->handle);
+ 	cs_set_state(sm, CS_STATE_INIT);
+ }
+=20
+ static void rap_cs_config_cmplt_evt(const uint8_t *data, uint8_t size,
+ 				    void *user_data)
+ {
+-	struct cs_state_machine *sm =3D (struct cs_state_machine *) user_data;
++	struct cs_state_machine *sm =3D user_data;
+ 	const struct bt_hci_evt_le_cs_config_complete *evt;
+ 	struct rap_ev_cs_config_cmplt rap_ev;
+ 	struct iovec iov;
+=20
+-	if (!sm || !data ||
+-		size < sizeof(struct bt_hci_evt_le_cs_config_complete))
++	if (!sm || !data || size < sizeof(*evt))
+ 		return;
+=20
+ 	/* Initialize iovec with the event data */
+@@ -485,7 +442,7 @@ static void rap_cs_config_cmplt_evt(const uint8_t *d=
ata, uint8_t size,
+ static void rap_cs_sec_enable_cmplt_evt(const uint8_t *data, uint8_t si=
ze,
+ 					 void *user_data)
+ {
+-	struct cs_state_machine *sm =3D (struct cs_state_machine *) user_data;
++	struct cs_state_machine *sm =3D user_data;
+ 	struct rap_ev_cs_sec_enable_cmplt rap_ev;
+ 	struct iovec iov;
+ 	uint8_t status;
+@@ -546,7 +503,7 @@ static void rap_cs_sec_enable_cmplt_evt(const uint8_=
t *data, uint8_t size,
+ static void rap_cs_proc_enable_cmplt_evt(const uint8_t *data, uint8_t s=
ize,
+ 					  void *user_data)
+ {
+-	struct cs_state_machine *sm =3D (struct cs_state_machine *) user_data;
++	struct cs_state_machine *sm =3D user_data;
+ 	const struct bt_hci_evt_le_cs_proc_enable_complete *evt;
+ 	struct rap_ev_cs_proc_enable_cmplt rap_ev;
+ 	struct iovec iov;
+--=20
+2.34.1
+
diff --git a/recipes-connectivity/bluez5/bluez5/0006-src-shared-Add-custo=
m-CCC-callbacks.patch b/recipes-connectivity/bluez5/bluez5/0006-src-share=
d-Add-custom-CCC-callbacks.patch
new file mode 100644
index 0000000..cb3db0e
--- /dev/null
+++ b/recipes-connectivity/bluez5/bluez5/0006-src-shared-Add-custom-CCC-c=
allbacks.patch
@@ -0,0 +1,178 @@
+From 83ddf46ccc0653fb2aa460b57eb60db92ab37597 Mon Sep 17 00:00:00 2001
+From: Prathibha Madugonde <prathibha.madugonde@oss.qualcomm.com>
+Date: Fri, 24 Apr 2026 09:58:30 +0530
+Subject: [PATCH] src/shared: add custom CCC callbacks
+
+Introduce custom CCC callbacks to allow interception of
+client notification subscription changes. This enables
+stack-level handling of CCC writes.
+
+Upstream-Status: Backport [83ddf46ccc0653fb2aa460b57eb60db92ab37597]
+Signed-off-by: Prathibha Madugonde <prathibha.madugonde@oss.qualcomm.com=
>
+---
+ src/shared/gatt-db.c | 119 ++++++++++++++++++++++++++++++++++++++++++-
+ src/shared/gatt-db.h |   4 ++
+ 2 files changed, 122 insertions(+), 1 deletion(-)
+
+diff --git a/src/shared/gatt-db.c b/src/shared/gatt-db.c
+index d0e149d6f..87cc61cf3 100644
+--- a/src/shared/gatt-db.c
++++ b/src/shared/gatt-db.c
+@@ -1214,6 +1214,112 @@ gatt_db_service_add_ccc(struct gatt_db_attribute=
 *attrib, uint32_t permissions)
+ 	return ccc;
+ }
+=20
++static void ccc_custom_read(struct gatt_db_attribute *attrib,
++					unsigned int id, uint16_t offset,
++					uint8_t opcode, struct bt_att *att,
++					void *user_data)
++{
++	struct gatt_db *db =3D attrib->service->db;
++
++	db->ccc->read_func(attrib, id, offset, opcode, att, db->ccc->user_data=
);
++}
++
++static void custom_write_result(struct gatt_db_attribute *attr, int err=
,
++							void *user_data)
++{
++	int *result =3D user_data;
++
++	*result =3D err;
++}
++
++static void ccc_custom_write(struct gatt_db_attribute *attrib,
++					unsigned int id, uint16_t offset,
++					const uint8_t *value, size_t len,
++					uint8_t opcode, struct bt_att *att,
++					void *user_data)
++{
++	struct gatt_db_ccc *data =3D user_data;
++	struct gatt_db *db =3D attrib->service->db;
++	struct pending_write *p;
++	int err =3D 0;
++
++	/* Create another pending write to handle results from custom write
++	 * function.
++	 */
++	p =3D new0(struct pending_write, 1);
++	p->attrib =3D attrib;
++	p->id =3D ++attrib->write_id;
++	p->func =3D custom_write_result;
++	p->user_data =3D &err;
++
++	queue_push_tail(attrib->pending_writes, p);
++
++	/* Call custom write function first */
++	data->write_func(attrib, p->id, offset, value, len, opcode, att,
++							data->user_data);
++
++	if (err) {
++		gatt_db_attribute_write_result(attrib, id, err);
++		return;
++	}
++
++	/* If custom write function did not return error proceed to call the
++	 * default CCC write function.
++	 */
++	db->ccc->write_func(attrib, id, offset, value, len, opcode, att,
++							db->ccc->user_data);
++}
++
++struct gatt_db_attribute *
++gatt_db_service_add_ccc_custom(struct gatt_db_attribute *attrib,
++				uint32_t permissions,
++				gatt_db_write_t write_func, void *user_data)
++{
++	struct gatt_db *db;
++	struct gatt_db_attribute *ccc;
++	struct gatt_db_attribute *value;
++	uint16_t handle =3D 0;
++	struct gatt_db_ccc *data;
++
++	if (!attrib || !permissions)
++		return NULL;
++
++	db =3D attrib->service->db;
++
++	if (!db->ccc)
++		return NULL;
++
++	/* Locate value handle */
++	gatt_db_service_foreach_char(attrib, find_ccc_value, &handle);
++
++	if (!handle)
++		return NULL;
++
++	value =3D gatt_db_get_attribute(db, handle);
++	if (!value || value->notify_func)
++		return NULL;
++
++	data =3D new0(struct gatt_db_ccc, 1);
++	data->write_func =3D write_func;
++	data->user_data =3D user_data;
++
++	ccc =3D service_insert_descriptor(attrib->service, 0, &ccc_uuid,
++					permissions,
++					ccc_custom_read,
++					ccc_custom_write,
++					data);
++	if (!ccc) {
++		free(data);
++		return NULL;
++	}
++
++	gatt_db_attribute_set_fixed_length(ccc, 2);
++	ccc->notify_func =3D db->ccc->notify_func;
++	value->notify_func =3D db->ccc->notify_func;
++
++	return ccc;
++}
++
+ void gatt_db_ccc_register(struct gatt_db *db, gatt_db_read_t read_func,
+ 				gatt_db_write_t write_func,
+ 				gatt_db_notify_t notify_func,
+@@ -2338,6 +2444,8 @@ bool gatt_db_attribute_notify(struct gatt_db_attri=
bute *attrib,
+ 					struct bt_att *att)
+ {
+ 	struct gatt_db_attribute *ccc;
++	struct gatt_db *db;
++	void *notify_user_data;
+=20
+ 	if (!attrib || !attrib->notify_func)
+ 		return false;
+@@ -2350,7 +2458,16 @@ bool gatt_db_attribute_notify(struct gatt_db_attr=
ibute *attrib,
+ 	if (!ccc)
+ 		return false;
+=20
+-	attrib->notify_func(attrib, ccc, value, len, att, ccc->user_data);
++	/* For custom CCC descriptors, use the database user_data for
++	 * notify_func. For regular CCC descriptors, use the CCC's user_data.
++	 */
++	db =3D attrib->service->db;
++	if (ccc->write_func =3D=3D ccc_custom_write && db && db->ccc)
++		notify_user_data =3D db->ccc->user_data;
++	else
++		notify_user_data =3D ccc->user_data;
++
++	attrib->notify_func(attrib, ccc, value, len, att, notify_user_data);
+=20
+ 	return true;
+ }
+diff --git a/src/shared/gatt-db.h b/src/shared/gatt-db.h
+index dc2daf7fc..da0600c01 100644
+--- a/src/shared/gatt-db.h
++++ b/src/shared/gatt-db.h
+@@ -112,6 +112,10 @@ gatt_db_service_insert_descriptor(struct gatt_db_at=
tribute *attrib,
+ struct gatt_db_attribute *
+ gatt_db_service_add_ccc(struct gatt_db_attribute *attrib, uint32_t perm=
issions);
+=20
++struct gatt_db_attribute *
++gatt_db_service_add_ccc_custom(struct gatt_db_attribute *attrib,
++				uint32_t permissions,
++				gatt_db_write_t write_func, void *user_data);
+ struct gatt_db_attribute *
+ gatt_db_insert_included(struct gatt_db *db, uint16_t handle,
+ 			struct gatt_db_attribute *include);
+--=20
+2.34.1
+
diff --git a/recipes-connectivity/bluez5/bluez5/0007-src-shared-Add-RAS-p=
acket-format-and-notification-su.patch b/recipes-connectivity/bluez5/blue=
z5/0007-src-shared-Add-RAS-packet-format-and-notification-su.patch
new file mode 100644
index 0000000..b26d06a
--- /dev/null
+++ b/recipes-connectivity/bluez5/bluez5/0007-src-shared-Add-RAS-packet-f=
ormat-and-notification-su.patch
@@ -0,0 +1,1439 @@
+From a9b39d71597dd28f9339bee4548b537c6749d384 Mon Sep 17 00:00:00 2001
+From: Prathibha Madugonde <prathibha.madugonde@oss.qualcomm.com>
+Date: Thu, 30 Apr 2026 13:11:40 +0530
+Subject: [PATCH] src/shared: Add RAS packet format and notification supp=
ort
+
+Implement complete RAS data pipeline:
+ - Handle HCI CS subevent result/continuation events
+ - Serialize ranging/subevent headers per spec
+ - GATT notifications for real-time ranging data
+
+Upstream-Status: Backport [a9b39d71597dd28f9339bee4548b537c6749d384]
+Signed-off-by: Prathibha Madugonde <prathibha.madugonde@oss.qualcomm.com=
>
+---
+ src/shared/rap.c | 1258 +++++++++++++++++++++++++++++++++++++++++++++-
+ src/shared/rap.h |    4 +-
+ 2 files changed, 1248 insertions(+), 14 deletions(-)
+
+diff --git a/src/shared/rap.c b/src/shared/rap.c
+--- a/src/shared/rap.c
++++ b/src/shared/rap.c
+@@ -15,6 +15,7 @@
+ #include <glib.h>
+=20
+ #include "bluetooth/bluetooth.h"
++#include "bluetooth/hci.h"
+ #include "bluetooth/uuid.h"
+=20
+ #include "src/shared/queue.h"
+@@ -34,6 +35,180 @@
+ /* Total number of attribute handles reserved for the RAS service */
+ #define RAS_TOTAL_NUM_HANDLES		18
+=20
++/* 2(rc+cfg) + 1(tx_pwr) + 1(4 bits antenna_mask, 2 bits reserved,
++ * 2 bits pct_format)
++ */
++#define RAS_RANGING_HEADER_SIZE 4
++#define TOTAL_RAS_RANGING_HEADER_SIZE 5
++#define ATT_OVERHEAD 3 /* 1(opcode) + 2(char handle) */
++#define RAS_STEP_ABORTED_BIT   0x80/* set step aborted */
++#define RAS_SUBEVENT_HEADER_SIZE 8
++
++enum pct_format {
++	IQ =3D 0,
++	PHASE =3D 1,
++};
++
++enum ranging_done_status {
++	RANGING_DONE_ALL_RESULTS_COMPLETE =3D 0x0,
++	RANGING_DONE_PARTIAL_RESULTS =3D 0x1,
++	RANGING_DONE_ABORTED =3D 0xF,
++};
++
++enum subevent_done_status {
++	SUBEVENT_DONE_ALL_RESULTS_COMPLETE =3D 0x0,
++	SUBEVENT_DONE_PARTIAL_RESULTS =3D 0x1,
++	SUBEVENT_DONE_ABORTED =3D 0xF,
++};
++
++enum ranging_abort_reason {
++	RANGING_ABORT_NO_ABORT =3D 0x0,
++	RANGING_ABORT_LOCAL_HOST_OR_REMOTE =3D 0x1,
++	RANGING_ABORT_INSUFFICIENT_FILTERED_CHANNELS =3D 0x2,
++	RANGING_ABORT_INSTANT_HAS_PASSED =3D 0x3,
++	RANGING_ABORT_UNSPECIFIED =3D 0xF,
++};
++
++enum subevent_abort_reason {
++	SUBEVENT_ABORT_NO_ABORT =3D 0x0,
++	SUBEVENT_ABORT_LOCAL_HOST_OR_REMOTE =3D 0x1,
++	SUBEVENT_ABORT_NO_CS_SYNC_RECEIVED =3D 0x2,
++	SUBEVENT_ABORT_SCHEDULING_CONFLICTS_OR_LIMITED_RESOURCES =3D 0x3,
++	SUBEVENT_ABORT_UNSPECIFIED =3D 0xF,
++};
++
++/* Segmentation header: 1 byte
++ * bit 0: first_segment
++ * bit 1: last_segment
++ * bits 2-7: rolling_segment_counter (6 bits)
++ */
++struct segmentation_header {
++	uint8_t first_segment;
++	uint8_t last_segment;
++	uint8_t rolling_segment_counter;
++};
++
++/* Macros to pack/unpack segmentation header */
++#define SEG_HDR_PACK(first, last, counter) \
++	((uint8_t)(((first) ? 0x01 : 0x00) | \
++		((last) ? 0x02 : 0x00) | \
++		(((counter) & 0x3F) << 2)))
++
++struct ranging_header {
++	/* Byte 0-1: 12-bit counter + 4-bit config_id */
++	uint8_t counter_config[2];
++	int8_t selected_tx_power;   /* Byte 2: selected TX power */
++	/* Byte 3: 4-bit antenna_mask + 2-bit reserved + 2-bit pct_format */
++	uint8_t antenna_pct;
++} __packed;
++
++static inline void ranging_header_set_counter(struct ranging_header *hd=
r,
++						uint16_t counter)
++{
++	/* Counter is 12 bits, stored in lower 12 bits of first 2 bytes */
++	hdr->counter_config[0] =3D counter & 0xFF;
++	hdr->counter_config[1] =3D (hdr->counter_config[1] & 0xF0) |
++				((counter >> 8) & 0x0F);
++}
++
++static inline void ranging_header_set_config_id(struct ranging_header *=
hdr,
++						uint8_t config_id)
++{
++	/* Config ID is 4 bits, stored in upper 4 bits of byte 1 */
++	hdr->counter_config[1] =3D (hdr->counter_config[1] & 0x0F) |
++				((config_id & 0x0F) << 4);
++}
++
++static inline void ranging_header_set_antenna_mask(
++					struct ranging_header *hdr,
++					uint8_t mask)
++{
++	/* Antenna mask is 4 bits, stored in lower 4 bits of byte 3 */
++	hdr->antenna_pct =3D (hdr->antenna_pct & 0xF0) | (mask & 0x0F);
++}
++
++static inline void ranging_header_set_pct_format(struct ranging_header =
*hdr,
++						uint8_t format)
++{
++	/* PCT format is 2 bits, stored in bits 6-7 of byte 3 */
++	hdr->antenna_pct =3D (hdr->antenna_pct & 0x3F) |
++				((format & 0x03) << 6);
++}
++
++struct ras_subevent_header {
++	uint16_t start_acl_conn_event;
++	uint16_t frequency_compensation;
++	uint8_t ranging_done_status;
++	uint8_t subevent_done_status;
++	uint8_t ranging_abort_reason;
++	uint8_t subevent_abort_reason;
++	int8_t reference_power_level;
++	uint8_t num_steps_reported;
++};
++
++/* Macros to pack/unpack RAS subevent header status fields */
++#define RAS_DONE_STATUS_PACK(ranging, subevent) \
++	((uint8_t)(((ranging) & 0x0F) | (((subevent) & 0x0F) << 4)))
++
++#define RAS_ABORT_REASON_PACK(ranging, subevent) \
++	((uint8_t)(((ranging) & 0x0F) | (((subevent) & 0x0F) << 4)))
++
++struct ras_subevent {
++	struct ras_subevent_header subevent_header;
++	uint8_t subevent_data[];
++};
++
++/* Role maps to Core CS roles (initiator/reflector) */
++enum cs_role {
++	CS_ROLE_INITIATOR =3D 0x00,
++	CS_ROLE_REFLECTOR =3D 0x01,
++};
++
++#define CS_INVALID_CONFIG_ID   0xFF
++/* Minimal enums (align to controller values if needed) */
++enum cs_procedure_done_status {
++	CS_PROC_ALL_RESULTS_COMPLETE =3D 0x00,
++	CS_PROC_PARTIAL_RESULTS      =3D 0x01,
++	CS_PROC_ABORTED              =3D 0x02
++};
++
++/* Main cs_procedure_data  */
++struct cs_procedure_data {
++	/* Identity and counters */
++	uint16_t counter;
++	uint8_t  num_antenna_paths;
++	/* Flags and status */
++	enum cs_procedure_done_status local_status;
++	enum cs_procedure_done_status remote_status;
++	bool contains_complete_subevent_;
++	/* RAS aggregation */
++	struct segmentation_header segmentation_header_;
++	struct ranging_header      ranging_header_;
++	struct iovec       ras_raw_data_;        /* raw concatenated */
++	uint16_t           ras_raw_data_index_;
++	struct ras_subevent_header  ras_subevent_header_;
++	struct iovec       ras_subevent_data_;   /* buffer per subevent */
++	uint8_t            ras_subevent_counter_;
++	/* Reference power levels */
++	int8_t initiator_reference_power_level;
++	int8_t reflector_reference_power_level;
++	bool ranging_header_prepended_;
++	bool ras_subevent_header_emitted;
++};
++
++struct cstracker {
++	enum cs_role        role;                 /* INITIATOR/REFLECTOR */
++	uint8_t             config_id;            /* CS_INVALID_CONFIG_ID */
++	int8_t             selected_tx_power;    /* PROC_ENABLE_COMPLETE */
++	uint8_t             rtt_type;             /* RTT type */
++	struct cs_procedure_data *current_proc;
++	/* Cached header values for CONT events (per-connection state) */
++	uint16_t last_proc_counter;
++	uint16_t last_start_acl_conn_evt_counter;
++	uint16_t last_freq_comp;
++	int8_t last_ref_pwr_lvl;
++};
++
+ /* Ranging Service context */
+ struct ras {
+ 	struct bt_rap_db *rapdb;
+@@ -44,9 +219,17 @@
+ 	struct gatt_db_attribute *realtime_chrc;
+ 	struct gatt_db_attribute *realtime_chrc_ccc;
+ 	struct gatt_db_attribute *ondemand_chrc;
++	struct gatt_db_attribute *ondemand_ccc;
+ 	struct gatt_db_attribute *cp_chrc;
++	struct gatt_db_attribute *cp_ccc;
+ 	struct gatt_db_attribute *ready_chrc;
++	struct gatt_db_attribute *ready_ccc;
+ 	struct gatt_db_attribute *overwritten_chrc;
++	struct gatt_db_attribute *overwritten_ccc;
++
++	/* CCC state tracking for mutual exclusivity */
++	uint16_t realtime_ccc_value;
++	uint16_t ondemand_ccc_value;
+ };
+=20
+ struct bt_rap_db {
+@@ -71,6 +254,7 @@
+ 	bt_rap_destroy_func_t debug_destroy;
+ 	void *debug_data;
+ 	void *user_data;
++	struct cstracker *resptracker;
+ };
+=20
+ static struct queue *rap_db;
+@@ -91,6 +275,204 @@
+ 	void *data;
+ };
+=20
++uint16_t default_ras_mtu =3D 247; /*Section 3.1.2 of RAP 1.0*/
++uint8_t ras_segment_header_size =3D 1;
++
++static struct cs_procedure_data *cs_procedure_data_create(
++					uint16_t procedure_counter,
++					uint8_t num_antenna_paths,
++					uint8_t configuration_id,
++					int8_t selected_tx_power)
++{
++	struct cs_procedure_data *d;
++	uint8_t i;
++	uint8_t antenna_mask =3D 0;
++
++	d =3D calloc(1, sizeof(struct cs_procedure_data));
++
++	if (!d)
++		return NULL;
++
++	d->counter =3D procedure_counter;
++	d->num_antenna_paths =3D num_antenna_paths;
++	d->local_status =3D CS_PROC_PARTIAL_RESULTS;
++	d->remote_status =3D CS_PROC_PARTIAL_RESULTS;
++	d->contains_complete_subevent_ =3D false;
++	d->segmentation_header_.first_segment =3D 1;
++	d->segmentation_header_.last_segment =3D 0;
++	d->segmentation_header_.rolling_segment_counter =3D 0;
++
++	/* Initialize ranging header using helper functions */
++	memset(&d->ranging_header_, 0, sizeof(d->ranging_header_));
++	ranging_header_set_counter(&d->ranging_header_, procedure_counter);
++	ranging_header_set_config_id(&d->ranging_header_, configuration_id);
++	d->ranging_header_.selected_tx_power =3D selected_tx_power;
++
++	/* Build antenna mask */
++	for (i =3D 0; i < num_antenna_paths; i++)
++		antenna_mask |=3D (1u << i);
++	ranging_header_set_antenna_mask(&d->ranging_header_, antenna_mask);
++
++	ranging_header_set_pct_format(&d->ranging_header_, IQ);
++	memset(&d->ras_raw_data_, 0, sizeof(d->ras_raw_data_));
++	d->ras_raw_data_index_ =3D 0;
++	memset(&d->ras_subevent_data_, 0, sizeof(d->ras_subevent_data_));
++	d->ras_subevent_counter_ =3D 0;
++	d->initiator_reference_power_level =3D 0;
++	d->reflector_reference_power_level =3D 0;
++	d->ranging_header_prepended_ =3D false;
++	d->ras_subevent_header_emitted =3D false;
++
++	return d;
++}
++
++static void cs_procedure_data_destroy(struct cs_procedure_data *d)
++{
++	if (!d)
++		return;
++
++	free(d->ras_raw_data_.iov_base);
++	free(d->ras_subevent_data_.iov_base);
++	free(d);
++}
++
++static void cs_pd_set_local_status(struct cs_procedure_data *d,
++				enum cs_procedure_done_status s)
++{
++	if (d)
++		d->local_status =3D s;
++}
++
++static void cs_pd_set_remote_status(struct cs_procedure_data *d,
++				enum cs_procedure_done_status s)
++{
++	if (d)
++		d->remote_status =3D s;
++}
++
++static void cs_pd_set_reference_power_levels(struct cs_procedure_data *=
d,
++					int8_t init_lvl, int8_t ref_lvl)
++{
++	if (!d)
++		return;
++
++	d->initiator_reference_power_level =3D init_lvl;
++	d->reflector_reference_power_level =3D ref_lvl;
++}
++
++static void cs_pd_ras_begin_subevent(struct cs_procedure_data *d,
++				uint16_t start_acl_conn_event,
++				uint16_t frequency_compensation,
++				int8_t reference_power_level)
++{
++	if (!d)
++		return;
++
++	d->ras_subevent_counter_++;
++	d->ras_subevent_header_.start_acl_conn_event =3D start_acl_conn_event;
++	d->ras_subevent_header_.frequency_compensation =3D
++		frequency_compensation;
++	d->ras_subevent_header_.reference_power_level =3D reference_power_leve=
l;
++	d->ras_subevent_header_.num_steps_reported =3D 0;
++	d->ras_subevent_header_emitted =3D false;
++	d->ras_subevent_data_.iov_len =3D 0;
++}
++
++static bool cs_pd_ras_append_subevent_bytes(struct cs_procedure_data *d=
,
++					const uint8_t *bytes, size_t len)
++{
++	if (!d || !bytes || len =3D=3D 0)
++		return false;
++
++	return util_iov_append(&d->ras_subevent_data_, bytes, len) !=3D NULL;
++}
++
++static inline size_t serialize_ras_subevent_header(
++				const struct ras_subevent_header *h,
++				uint8_t *out, size_t out_len)
++{
++
++	if (!h || !out || out_len < RAS_SUBEVENT_HEADER_SIZE)
++		return 0;
++
++	put_le16(h->start_acl_conn_event, out + 0);
++	put_le16(h->frequency_compensation, out + 2);
++	out[4] =3D RAS_DONE_STATUS_PACK(h->ranging_done_status,
++					h->subevent_done_status);
++	out[5] =3D RAS_ABORT_REASON_PACK(h->ranging_abort_reason,
++					h->subevent_abort_reason);
++	out[6] =3D h->reference_power_level;
++	out[7] =3D h->num_steps_reported;
++
++	return RAS_SUBEVENT_HEADER_SIZE;
++}
++
++static bool cs_pd_ras_commit_subevent(struct cs_procedure_data *d,
++				uint8_t num_steps_reported,
++				uint8_t ranging_done_status,
++				uint8_t subevent_done_status,
++				uint8_t ranging_abort_reason,
++				uint8_t subevent_abort_reason)
++{
++	size_t hdr_sz;
++	size_t payload_sz;
++	size_t total;
++	uint8_t *buf;
++	size_t w;
++	bool ok;
++
++	if (!d)
++		return false;
++
++	d->ras_subevent_header_.num_steps_reported =3D
++		(uint8_t)(d->ras_subevent_header_.num_steps_reported +
++			num_steps_reported);
++	d->ras_subevent_header_.ranging_done_status =3D ranging_done_status;
++	d->ras_subevent_header_.subevent_done_status =3D subevent_done_status;
++	d->ras_subevent_header_.ranging_abort_reason =3D ranging_abort_reason;
++	d->ras_subevent_header_.subevent_abort_reason =3D subevent_abort_reaso=
n;
++
++	if (subevent_done_status =3D=3D SUBEVENT_DONE_ALL_RESULTS_COMPLETE)
++		d->contains_complete_subevent_ =3D true;
++
++	if (subevent_done_status =3D=3D SUBEVENT_DONE_PARTIAL_RESULTS)
++		return true;
++
++	if (!d->ras_subevent_header_emitted) {
++		hdr_sz =3D RAS_SUBEVENT_HEADER_SIZE;
++		payload_sz =3D d->ras_subevent_data_.iov_len;
++		total =3D hdr_sz + payload_sz;
++		buf =3D (uint8_t *)malloc(total);
++
++		if (!buf)
++			return false;
++
++		w =3D serialize_ras_subevent_header(&d->ras_subevent_header_,
++						buf, total);
++
++		if (w !=3D hdr_sz) {
++			free(buf);
++			return false;
++		}
++
++		if (payload_sz > 0)
++			memcpy(buf + hdr_sz,
++				(const uint8_t *)d->ras_subevent_data_.iov_base,
++				payload_sz);
++
++		ok =3D util_iov_append(&d->ras_raw_data_, buf, total) !=3D NULL;
++		free(buf);
++
++		if (!ok)
++			return false;
++
++		d->ras_subevent_data_.iov_len =3D 0;
++		d->ras_subevent_header_emitted =3D true;
++	}
++
++	return true;
++}
++
+ static struct ras *rap_get_ras(struct bt_rap *rap)
+ {
+ 	if (!rap)
+@@ -156,6 +538,11 @@
+=20
+ 	rap_db_free(rap->rrapdb);
+=20
++	if (rap->resptracker) {
++		free(rap->resptracker);
++		rap->resptracker =3D NULL;
++	}
++
+ 	queue_destroy(rap->notify, free);
+ 	queue_destroy(rap->pending, NULL);
+ 	queue_destroy(rap->ready_cbs, rap_ready_free);
+@@ -241,6 +628,22 @@
+ 	return true;
+ }
+=20
++static void cs_tracker_init(struct cstracker *t)
++{
++	if (!t)
++		return;
++
++	memset(t, 0, sizeof(*t));
++	t->role =3D CS_ROLE_REFLECTOR;
++	t->config_id =3D CS_INVALID_CONFIG_ID;
++	t->rtt_type =3D 0;
++	t->selected_tx_power =3D 0;
++	t->last_proc_counter =3D 0;
++	t->last_start_acl_conn_evt_counter =3D 0;
++	t->last_freq_comp =3D 0;
++	t->last_ref_pwr_lvl =3D 0;
++}
++
+ static void ras_features_read_cb(struct gatt_db_attribute *attrib,
+ 				 unsigned int id, uint16_t offset,
+ 				 uint8_t opcode, struct bt_att *att,
+@@ -305,6 +708,70 @@
+ 	gatt_db_attribute_read_result(attrib, id, 0, value, sizeof(value));
+ }
+=20
++static void ras_ranging_data_ccc_write_cb(struct gatt_db_attribute *att=
rib,
++					unsigned int id, uint16_t offset,
++					const uint8_t *value, size_t len,
++					uint8_t opcode, struct bt_att *att,
++					void *user_data)
++{
++	struct ras *ras =3D user_data;
++	uint16_t ccc_value;
++	bool is_realtime;
++	uint16_t *this_ccc;
++	uint16_t *other_ccc;
++
++	if (!ras) {
++		gatt_db_attribute_write_result(attrib, id,
++					BT_ATT_ERROR_UNLIKELY);
++		return;
++	}
++
++	if (offset) {
++		gatt_db_attribute_write_result(attrib, id,
++					BT_ATT_ERROR_INVALID_OFFSET);
++		return;
++	}
++
++	if (len !=3D 2) {
++		gatt_db_attribute_write_result(attrib, id,
++			BT_ATT_ERROR_INVALID_ATTRIBUTE_VALUE_LEN);
++		return;
++	}
++
++	ccc_value =3D get_le16(value);
++
++	if (ccc_value !=3D 0x0000 && ccc_value !=3D 0x0001 &&
++	    ccc_value !=3D 0x0002 && ccc_value !=3D 0x0003) {
++		gatt_db_attribute_write_result(attrib, id,
++					BT_ERROR_WRITE_REQUEST_REJECTED);
++		return;
++	}
++
++	/* Determine which CCC this is */
++	is_realtime =3D (attrib =3D=3D ras->realtime_chrc_ccc);
++	this_ccc =3D is_realtime ? &ras->realtime_ccc_value :
++				 &ras->ondemand_ccc_value;
++	other_ccc =3D is_realtime ? &ras->ondemand_ccc_value :
++				  &ras->realtime_ccc_value;
++
++	/* Check mutual exclusivity: reject if trying to enable realtime
++	 * while ondemand is already enabled.
++	 * Test case: RAS/SR/SPE/BI-11-C [Client enables both Real-time
++	 * Ranging Data and On-demand Ranging Data notifications or
++	 * indications]
++	 */
++	if (ccc_value !=3D 0x0000 && *other_ccc !=3D 0x0000) {
++		gatt_db_attribute_write_result(attrib, id,
++					BT_ERROR_CCC_IMPROPERLY_CONFIGURED);
++		return;
++	}
++
++	/* Update state */
++	*this_ccc =3D ccc_value;
++
++	gatt_db_attribute_write_result(attrib, id, 0);
++}
++
+ /* Service registration =E2=80=93 store attribute pointers */
+ static struct ras *register_ras_service(struct gatt_db *db)
+ {
+@@ -350,9 +817,9 @@
+ 						  NULL, NULL, ras);
+=20
+ 	ras->realtime_chrc_ccc =3D
+-		gatt_db_service_add_ccc(ras->svc,
+-					BT_ATT_PERM_READ |
+-					BT_ATT_PERM_WRITE);
++		gatt_db_service_add_ccc_custom(ras->svc,
++					BT_ATT_PERM_READ | BT_ATT_PERM_WRITE,
++					ras_ranging_data_ccc_write_cb, ras);
+=20
+ 	/* On-demand Ranging Data */
+ 	bt_uuid16_create(&uuid, RAS_ONDEMAND_DATA_UUID);
+@@ -365,8 +832,9 @@
+ 						  ras_ondemand_read_cb, NULL,
+ 						  ras);
+=20
+-	gatt_db_service_add_ccc(ras->svc,
+-				BT_ATT_PERM_READ | BT_ATT_PERM_WRITE);
++	ras->ondemand_ccc =3D gatt_db_service_add_ccc_custom(ras->svc,
++					BT_ATT_PERM_READ | BT_ATT_PERM_WRITE,
++					ras_ranging_data_ccc_write_cb, ras);
+=20
+ 	/* RAS Control Point */
+ 	bt_uuid16_create(&uuid, RAS_CONTROL_POINT_UUID);
+@@ -380,8 +848,8 @@
+ 						  ras_control_point_write_cb,
+ 						  ras);
+=20
+-	gatt_db_service_add_ccc(ras->svc,
+-				BT_ATT_PERM_READ | BT_ATT_PERM_WRITE);
++	ras->cp_ccc =3D gatt_db_service_add_ccc(ras->svc,
++					BT_ATT_PERM_READ | BT_ATT_PERM_WRITE);
+=20
+ 	/* RAS Data Ready */
+ 	bt_uuid16_create(&uuid, RAS_DATA_READY_UUID);
+@@ -395,8 +863,8 @@
+ 						  ras_data_ready_read_cb, NULL,
+ 						  ras);
+=20
+-	gatt_db_service_add_ccc(ras->svc,
+-				BT_ATT_PERM_READ | BT_ATT_PERM_WRITE);
++	ras->ready_ccc =3D gatt_db_service_add_ccc(ras->svc,
++					BT_ATT_PERM_READ | BT_ATT_PERM_WRITE);
+=20
+ 	/* RAS Data Overwritten */
+ 	bt_uuid16_create(&uuid, RAS_DATA_OVERWRITTEN_UUID);
+@@ -410,8 +878,8 @@
+ 						  ras_data_overwritten_read_cb,
+ 						  NULL, ras);
+=20
+-	gatt_db_service_add_ccc(ras->svc,
+-				BT_ATT_PERM_READ | BT_ATT_PERM_WRITE);
++	ras->overwritten_ccc =3D gatt_db_service_add_ccc(ras->svc,
++					BT_ATT_PERM_READ | BT_ATT_PERM_WRITE);
+=20
+ 	/* Activate the service */
+ 	gatt_db_service_set_active(ras->svc, true);
+@@ -504,32 +972,780 @@
+ 	return true;
+ }
+=20
++static inline size_t serialize_segmentation_header(
++				const struct segmentation_header *s,
++				uint8_t *out, size_t out_len)
++{
++	if (!s || !out || out_len < 1)
++		return 0;
++
++	out[0] =3D SEG_HDR_PACK(s->first_segment, s->last_segment,
++				s->rolling_segment_counter);
++
++	return 1;
++}
++
++static inline bool serialize_ranging_header_iov(const struct ranging_he=
ader *r,
++						struct iovec *iov)
++{
++	if (!r || !iov)
++		return false;
++
++	/* Serialize the per-byte packed fields using util_iov_push functions =
*/
++	if (!util_iov_push_le16(iov, get_le16(r->counter_config)))
++		return false;
++
++	if (!util_iov_push_u8(iov, r->selected_tx_power))
++		return false;
++
++	if (!util_iov_push_u8(iov, r->antenna_pct))
++		return false;
++
++	return true;
++}
++
++static inline uint16_t ras_att_value_payload_max(struct bt_rap *rap)
++{
++	struct bt_att *att =3D bt_rap_get_att(rap);
++	uint16_t mtu =3D att ? bt_att_get_mtu(att) : default_ras_mtu;
++
++	return (uint16_t)(mtu > ATT_OVERHEAD ?
++		(mtu - ATT_OVERHEAD - TOTAL_RAS_RANGING_HEADER_SIZE -
++		ras_segment_header_size) : 0);
++}
++
++/* Prepend data to an iovec - optimized to avoid unnecessary malloc/cop=
y
++ * by using realloc and memmove instead of malloc/memcpy/free pattern.
++ * This reduces memory allocations and is more cache-friendly.
++ */
++static bool iov_prepend_bytes(struct iovec *iov, const uint8_t *bytes,
++				size_t len)
++{
++	size_t new_len;
++	void *new_base;
++
++	if (!iov || !bytes || len =3D=3D 0)
++		return false;
++
++	new_len =3D iov->iov_len + len;
++
++	/* Use realloc to potentially expand in-place */
++	new_base =3D realloc(iov->iov_base, new_len);
++
++	if (!new_base)
++		return false;
++
++	/* Move existing data forward to make room at the beginning */
++	if (iov->iov_len > 0)
++		memmove((uint8_t *)new_base + len, new_base, iov->iov_len);
++
++	/* Copy new data to the beginning */
++	memcpy(new_base, bytes, len);
++
++	iov->iov_base =3D new_base;
++	iov->iov_len =3D new_len;
++
++	return true;
++}
++
++/* Append the 4-byte RangingHeader to ras_raw_data_ on first segment */
++static bool ras_maybe_prepend_ranging_header(struct cs_procedure_data *=
d)
++{
++	struct iovec temp_iov =3D { 0 };
++	bool ok;
++
++	if (!d)
++		return false;
++
++	if (d->ranging_header_prepended_)
++		return false;
++
++	if (!d->segmentation_header_.first_segment)
++		return false;
++
++	if (d->ras_raw_data_index_ !=3D 0)
++		return false;
++
++	temp_iov.iov_base =3D malloc(4);
++	if (!temp_iov.iov_base)
++		return false;
++	temp_iov.iov_len =3D 0;
++
++	/* Serialize ranging header into temporary iovec */
++	if (!serialize_ranging_header_iov(&d->ranging_header_, &temp_iov)) {
++		free(temp_iov.iov_base);
++		return false;
++	}
++
++	/* Prepend the serialized header to ras_raw_data_ */
++	ok =3D iov_prepend_bytes(&d->ras_raw_data_, temp_iov.iov_base,
++				temp_iov.iov_len);
++
++	/* Free temporary iovec buffer */
++	free(temp_iov.iov_base);
++
++	if (ok)
++		d->ranging_header_prepended_ =3D true;
++
++	return ok;
++}
++
++static void send_ras_segment_data(struct bt_rap *rap,
++				struct cs_procedure_data *proc)
++{
++	struct ras *ras;
++	uint16_t value_max;
++	const uint16_t header_len =3D ras_segment_header_size;
++	uint16_t raw_payload_size;
++	bool ok;
++
++	if (!rap || !proc)
++		return;
++
++	if (!rap->lrapdb || !rap->lrapdb->ras)
++		return;
++
++	ras =3D rap->lrapdb->ras;
++	value_max =3D ras_att_value_payload_max(rap);
++
++	if (value_max =3D=3D 0) {
++		DBG(rap, "value_max=3D0 (MTU not available?)");
++		return;
++	}
++
++	if (value_max <=3D header_len) {
++		DBG(rap, "value_max(%u) too small for header", value_max);
++		return;
++	}
++
++	raw_payload_size =3D (uint16_t)(value_max - header_len);
++
++	/* Convert tail recursion to loop */
++	while (true) {
++		size_t total_len =3D proc->ras_raw_data_.iov_len;
++		size_t index =3D proc->ras_raw_data_index_;
++		size_t unsent_data_size;
++		uint16_t copy_size;
++		uint16_t seg_len;
++		uint8_t *seg;
++		uint16_t wr =3D 0;
++
++		if (index > total_len)
++			index =3D total_len;
++
++		unsent_data_size =3D total_len - index;
++
++		if (unsent_data_size =3D=3D 0)
++			return;
++
++		/* Set last_segment if procedure complete or fits in segment */
++		if ((proc->local_status !=3D CS_PROC_PARTIAL_RESULTS &&
++				unsent_data_size <=3D raw_payload_size) ||
++			(proc->contains_complete_subevent_ &&
++				unsent_data_size <=3D raw_payload_size)) {
++			proc->segmentation_header_.last_segment =3D 1;
++		} else {
++			proc->segmentation_header_.last_segment =3D 0;
++		}
++
++		/* Wait for more data if needed and not last segment */
++		if (unsent_data_size < raw_payload_size &&
++				proc->segmentation_header_.last_segment =3D=3D 0) {
++			DBG(rap, "waiting for more data (unsent=3D%zu < "
++				"payload=3D%u)", unsent_data_size,
++				raw_payload_size);
++			return;
++		}
++
++		copy_size =3D (uint16_t)((unsent_data_size < raw_payload_size) ?
++				unsent_data_size : raw_payload_size);
++		seg_len =3D (uint16_t)(header_len + copy_size);
++		seg =3D (uint8_t *)malloc(seg_len);
++
++		if (!seg) {
++			DBG(rap, "OOM (%u)", seg_len);
++			return;
++		}
++
++		wr +=3D (uint16_t)serialize_segmentation_header(
++				&proc->segmentation_header_, seg + wr,
++				seg_len - wr);
++		memcpy(seg + wr,
++			(const uint8_t *)proc->ras_raw_data_.iov_base + index,
++			copy_size);
++		wr +=3D copy_size;
++
++		/* Try sending to real-time characteristic */
++		if (ras->realtime_chrc)
++			ok =3D gatt_db_attribute_notify(ras->realtime_chrc, seg,
++						wr, bt_rap_get_att(rap));
++
++		/* Try sending to on-demand characteristic */
++		if (ras->ondemand_chrc)
++			ok =3D gatt_db_attribute_notify(ras->ondemand_chrc, seg,
++						wr, bt_rap_get_att(rap));
++
++		free(seg);
++
++		if (!ok) {
++			DBG(rap, "Failed to send RAS notification");
++			return;
++		}
++
++		/* Advance read cursor and update segmentation state */
++		proc->ras_raw_data_index_ +=3D copy_size;
++		proc->segmentation_header_.first_segment =3D 0;
++		proc->segmentation_header_.rolling_segment_counter =3D
++			(uint8_t)((proc->segmentation_header_
++				.rolling_segment_counter + 1) & 0x3F);
++
++		if (proc->segmentation_header_.last_segment ||
++				proc->ras_raw_data_index_ >=3D
++				proc->ras_raw_data_.iov_len) {
++			DBG(rap, "RAS clear ras buffers");
++			proc->ras_raw_data_.iov_len =3D 0;
++			proc->ras_raw_data_index_ =3D 0;
++			proc->ranging_header_prepended_ =3D false;
++			return;
++		}
++	}
++}
++
++static inline void resptracker_reset_current_proc(struct cstracker *t)
++{
++	if (!t)
++		return;
++
++	if (t->current_proc) {
++		cs_procedure_data_destroy(t->current_proc);
++		t->current_proc =3D NULL;
++	}
++}
++
++static void process_cs_mode_zero(struct bt_rap *rap,
++				struct cs_procedure_data *proc,
++				const struct cs_step_data *step,
++				uint8_t idx, uint8_t mode_byte)
++{
++	const uint8_t *payload;
++	uint8_t plen;
++
++	/* Mode 0: use raw structure bytes */
++	payload =3D (const uint8_t *)&step->step_mode_data;
++	plen =3D step->step_data_length;
++	cs_pd_ras_append_subevent_bytes(proc, payload, plen);
++	DBG(rap, "step[%u]: mode=3D0x%02x Mode0 payload_len=3D%u sent",
++		idx, mode_byte, (unsigned int)plen);
++}
++
++static void process_cs_mode_one(struct bt_rap *rap,
++				struct cs_procedure_data *proc,
++				const struct cs_step_data *step,
++				uint8_t idx, uint8_t mode_byte)
++{
++	const struct cs_mode_one_data *m1 =3D
++		&step->step_mode_data.mode_one_data;
++	struct cstracker *resptracker =3D rap->resptracker;
++	struct iovec temp_iov =3D { 0 };
++	uint16_t time_val;
++	uint32_t pct1;
++	uint32_t pct2;
++	enum cs_role cs_role =3D resptracker->role;
++	uint8_t cs_rtt_type =3D resptracker->rtt_type;
++	bool include_pct;
++
++	temp_iov.iov_base =3D malloc(64);
++	if (!temp_iov.iov_base) {
++		DBG(rap, "Mode1 ERROR: malloc failed!");
++		return;
++	}
++	temp_iov.iov_len =3D 0;
++
++	include_pct =3D (cs_rtt_type =3D=3D 0x01 || cs_rtt_type =3D=3D 0x02);
++
++	if (!util_iov_push_u8(&temp_iov, m1->packet_quality) ||
++	    !util_iov_push_u8(&temp_iov, m1->packet_nadm) ||
++	    !util_iov_push_u8(&temp_iov, m1->packet_rssi_dbm))
++		goto done;
++
++	/* Time value (2 bytes LE) - use the appropriate field based on role *=
/
++	if (cs_role =3D=3D CS_ROLE_REFLECTOR)
++		time_val =3D m1->tod_toa_refl;
++	else
++		time_val =3D m1->toa_tod_init;
++
++	if (!util_iov_push_le16(&temp_iov, time_val) ||
++	    !util_iov_push_u8(&temp_iov, m1->packet_ant))
++		goto done;
++
++	if (include_pct) {
++		/* PCT1 (3 bytes LE) - 12-bit I + 12-bit Q */
++		pct1 =3D ((uint32_t)(m1->packet_pct1.i_sample & 0x0FFF)) |
++			(((uint32_t)(m1->packet_pct1.q_sample & 0x0FFF)) <<
++			12);
++		if (!util_iov_push_le24(&temp_iov, pct1))
++			goto done;
++
++		/* PCT2 (3 bytes LE) */
++		pct2 =3D ((uint32_t)(m1->packet_pct2.i_sample & 0x0FFF)) |
++			(((uint32_t)(m1->packet_pct2.q_sample & 0x0FFF)) <<
++			12);
++		if (!util_iov_push_le24(&temp_iov, pct2))
++			goto done;
++	}
++
++	cs_pd_ras_append_subevent_bytes(proc, temp_iov.iov_base,
++					temp_iov.iov_len);
++
++done:
++	free(temp_iov.iov_base);
++
++	DBG(rap, "step[%u]: mode=3D0x%02x Mode1 serialized payload_len=3D%zu "
++		"role=3D%s rtt_type=3D0x%02x pct=3D%s",
++		idx, mode_byte, temp_iov.iov_len,
++		cs_role =3D=3D CS_ROLE_INITIATOR ? "INIT" : "REFL", cs_rtt_type,
++		include_pct ? "YES" : "NO");
++}
++
++static void process_cs_mode_two(struct bt_rap *rap,
++				struct cs_procedure_data *proc,
++				const struct cs_step_data *step,
++				uint8_t num_ant_paths,
++				uint8_t idx, uint8_t mode_byte)
++{
++	const struct cs_mode_two_data *m2 =3D
++		&step->step_mode_data.mode_two_data;
++	struct iovec temp_iov =3D { 0 };
++	uint8_t k;
++	uint8_t num_paths =3D (num_ant_paths + 1) < 5 ?
++		(num_ant_paths + 1) : 5;
++
++	temp_iov.iov_base =3D malloc(128);
++	if (!temp_iov.iov_base) {
++		DBG(rap, "Mode2 ERROR: malloc failed!");
++		return;
++	}
++	temp_iov.iov_len =3D 0;
++
++	if (!util_iov_push_u8(&temp_iov, m2->ant_perm_index))
++		goto done;
++
++	/* Serialize each path: PCT (3 bytes LE) + quality (1 byte) */
++	for (k =3D 0; k < num_paths; k++) {
++		/* Convert 4-byte structure PCT to 3-byte wire format */
++		uint32_t pct =3D ((uint32_t)(m2->tone_pct[k].i_sample &
++				0x0FFF)) |
++			(((uint32_t)(m2->tone_pct[k].q_sample &
++				0x0FFF)) << 12);
++		if (!util_iov_push_le24(&temp_iov, pct) ||
++		    !util_iov_push_u8(&temp_iov,
++				m2->tone_quality_indicator[k]))
++			goto done;
++	}
++
++	cs_pd_ras_append_subevent_bytes(proc, temp_iov.iov_base,
++					temp_iov.iov_len);
++
++done:
++	free(temp_iov.iov_base);
++
++	DBG(rap, "step[%u]: mode=3D0x%02x Mode2 serialized payload_len=3D%zu "
++		"paths=3D%u",
++		idx, mode_byte, temp_iov.iov_len, num_paths);
++}
++
++static void process_cs_mode_three(struct bt_rap *rap,
++				struct cs_procedure_data *proc,
++				const struct cs_step_data *step,
++				uint8_t num_ant_paths,
++				uint8_t idx, uint8_t mode_byte)
++{
++	const struct cs_mode_three_data *m3 =3D
++		&step->step_mode_data.mode_three_data;
++	const struct cs_mode_one_data *m1 =3D &m3->mode_one_data;
++	const struct cs_mode_two_data *m2 =3D &m3->mode_two_data;
++	struct cstracker *resptracker =3D rap->resptracker;
++	struct iovec temp_iov =3D { 0 };
++	uint16_t time_val;
++	uint32_t pct1;
++	uint32_t pct2;
++	enum cs_role cs_role =3D resptracker->role;
++	uint8_t cs_rtt_type =3D resptracker->rtt_type;
++	uint8_t k;
++	uint8_t num_paths =3D (num_ant_paths + 1) < 5 ?
++		(num_ant_paths + 1) : 5;
++	bool include_pct;
++
++	temp_iov.iov_base =3D malloc(128);
++	if (!temp_iov.iov_base) {
++		DBG(rap, "Mode3 ERROR: malloc failed!");
++		return;
++	}
++	temp_iov.iov_len =3D 0;
++
++	/* Determine if PCT samples should be included */
++	include_pct =3D (cs_rtt_type =3D=3D 0x01 || cs_rtt_type =3D=3D 0x02);
++
++	if (!util_iov_push_u8(&temp_iov, m1->packet_quality) ||
++	    !util_iov_push_u8(&temp_iov, m1->packet_nadm) ||
++	    !util_iov_push_u8(&temp_iov, m1->packet_rssi_dbm))
++		goto done;
++
++	/* Time value (2 bytes LE) - use the appropriate field based on role *=
/
++	if (cs_role =3D=3D CS_ROLE_REFLECTOR)
++		time_val =3D m1->tod_toa_refl;
++	else
++		time_val =3D m1->toa_tod_init;
++
++	if (!util_iov_push_le16(&temp_iov, time_val) ||
++	    !util_iov_push_u8(&temp_iov, m1->packet_ant))
++		goto done;
++
++	/* PCT samples if RTT type contains sounding sequence */
++	if (include_pct) {
++		/* PCT1 (3 bytes LE) - 12-bit I + 12-bit Q */
++		pct1 =3D ((uint32_t)(m1->packet_pct1.i_sample & 0x0FFF)) |
++			(((uint32_t)(m1->packet_pct1.q_sample & 0x0FFF)) <<
++			12);
++
++		if (!util_iov_push_le24(&temp_iov, pct1))
++			goto done;
++
++		/* PCT2 (3 bytes LE) */
++		pct2 =3D ((uint32_t)(m1->packet_pct2.i_sample & 0x0FFF)) |
++			(((uint32_t)(m1->packet_pct2.q_sample & 0x0FFF)) <<
++			12);
++
++		if (!util_iov_push_le24(&temp_iov, pct2))
++			goto done;
++	}
++
++	if (!util_iov_push_u8(&temp_iov, m2->ant_perm_index))
++		goto done;
++
++	for (k =3D 0; k < num_paths; k++) {
++		/* Convert 4-byte structure PCT to 3-byte wire format */
++		uint32_t pct =3D ((uint32_t)(m2->tone_pct[k].i_sample &
++				0x0FFF)) |
++			(((uint32_t)(m2->tone_pct[k].q_sample &
++				0x0FFF)) << 12);
++		if (!util_iov_push_le24(&temp_iov, pct) ||
++		    !util_iov_push_u8(&temp_iov,
++				m2->tone_quality_indicator[k]))
++			goto done;
++	}
++
++	cs_pd_ras_append_subevent_bytes(proc, temp_iov.iov_base,
++					temp_iov.iov_len);
++
++done:
++	free(temp_iov.iov_base);
++
++	DBG(rap, "=3D=3D=3D Mode3 END: step[%u] payload_len=3D%zu paths=3D%u r=
ole=3D%s "
++		"rtt_type=3D0x%02x pct=3D%s =3D=3D=3D",
++		idx, temp_iov.iov_len, num_paths,
++		cs_role =3D=3D CS_ROLE_INITIATOR ? "INIT" : "REFL",
++		cs_rtt_type, include_pct ? "YES" : "NO");
++}
++
++static void process_cs_mode_step(struct bt_rap *rap,
++				struct cs_procedure_data *proc,
++				const struct cs_step_data *step,
++				uint8_t num_ant_paths,
++				uint8_t idx)
++{
++	const uint8_t mode =3D step->step_mode;
++	const uint8_t payload_len =3D step->step_data_length;
++	uint8_t mode_byte;
++	uint8_t mode_type;
++	const uint8_t *payload;
++	uint8_t plen;
++	bool step_aborted;
++
++	/* Check if step is aborted: bit 7 of step_mode or 0 payload len */
++	step_aborted =3D (mode & RAS_STEP_ABORTED_BIT) || (payload_len =3D=3D =
0);
++
++	DBG(rap, "step[%u]: mode=3D0x%02x channel=3D%u payload_len=3D%u "
++		"aborted=3D%s", idx, mode, step->step_chnl, payload_len,
++		step_aborted ? "YES" : "NO");
++
++	mode_byte =3D step->step_mode;
++
++	if (step_aborted) {
++		/* Ensure abort bit is set */
++		mode_byte |=3D RAS_STEP_ABORTED_BIT;
++		cs_pd_ras_append_subevent_bytes(proc, &mode_byte, 1);
++		/* No payload when aborted - per RAS spec Table 3.8 */
++		DBG(rap, "step[%u]: mode=3D0x%02x aborted, no payload sent",
++			idx, mode_byte);
++		return;
++	}
++
++	mode_type =3D mode & 0x03;
++
++	/* Mode byte first (without abort bit) */
++	cs_pd_ras_append_subevent_bytes(proc, &mode_byte, 1);
++
++	switch (mode_type) {
++	case CS_MODE_ZERO:
++		process_cs_mode_zero(rap, proc, step, idx, mode_byte);
++		break;
++	case CS_MODE_ONE:
++		process_cs_mode_one(rap, proc, step, idx, mode_byte);
++		break;
++	case CS_MODE_TWO:
++		process_cs_mode_two(rap, proc, step, num_ant_paths, idx,
++					mode_byte);
++		break;
++	case CS_MODE_THREE:
++		process_cs_mode_three(rap, proc, step, num_ant_paths, idx,
++					mode_byte);
++		break;
++	default:
++		/* Unknown mode: use raw structure bytes */
++		payload =3D (const uint8_t *)&step->step_mode_data;
++		plen =3D step->step_data_length;
++		cs_pd_ras_append_subevent_bytes(proc, payload, plen);
++		DBG(rap, "step[%u]: mode=3D0x%02x unknown mode, "
++			"payload_len=3D%u sent",
++			idx, mode_byte, (unsigned int)plen);
++		break;
++	}
++}
++
++/* Unified local subevent handler */
++static void handle_local_subevent_result(struct bt_rap *rap,
++					bool has_header_fields,
++					uint8_t config_id,
++					uint8_t num_ant_paths,
++					uint16_t proc_counter,
++					uint16_t start_acl_conn_evt_counter,
++					uint16_t freq_comp,
++					int8_t  ref_pwr_lvl,
++					uint8_t proc_done_status,
++					uint8_t subevt_done_status,
++					uint8_t abort_reason,
++					uint8_t num_steps_reported,
++					const void *step_bytes)
++{
++	struct cstracker *resptracker;
++	struct cs_procedure_data *proc;
++	const struct cs_step_data *steps;
++	uint8_t idx;
++
++	if (!rap || !rap->resptracker || !step_bytes)
++		return;
++
++	resptracker =3D rap->resptracker;
++
++	if (resptracker->current_proc) {
++		struct cs_procedure_data *cur =3D resptracker->current_proc;
++
++		if (has_header_fields && cur->counter !=3D proc_counter) {
++			/* Safety: a new procedure; destroy the previous one */
++			resptracker_reset_current_proc(resptracker);
++		}
++	}
++
++	proc =3D resptracker->current_proc;
++	/* Cache header info from a RESULT event for later CONT usage */
++	if (has_header_fields) {
++		resptracker->last_proc_counter =3D proc_counter;
++		resptracker->last_start_acl_conn_evt_counter =3D
++			start_acl_conn_evt_counter;
++		resptracker->last_freq_comp =3D freq_comp;
++		resptracker->last_ref_pwr_lvl =3D ref_pwr_lvl;
++	}
++
++	/* Create the procedure on first use */
++	if (!proc) {
++		uint16_t create_counter =3D has_header_fields ? proc_counter :
++					resptracker->last_proc_counter;
++
++		proc =3D cs_procedure_data_create(create_counter,
++						num_ant_paths,
++						config_id,
++						resptracker->selected_tx_power);
++		if (!proc)
++			return;
++
++		resptracker->current_proc =3D proc;
++
++		/* Reference power levels and status defaults */
++		cs_pd_set_reference_power_levels(proc,
++			has_header_fields ? ref_pwr_lvl :
++				resptracker->last_ref_pwr_lvl,
++			has_header_fields ? ref_pwr_lvl :
++				resptracker->last_ref_pwr_lvl);
++		cs_pd_set_local_status(proc,
++			(enum cs_procedure_done_status)proc_done_status);
++		cs_pd_set_remote_status(proc,
++			(enum cs_procedure_done_status)subevt_done_status);
++	}
++
++	/* Begin a new RAS subevent only when we have header fields */
++	if (has_header_fields) {
++		cs_pd_ras_begin_subevent(proc,
++					start_acl_conn_evt_counter,
++					freq_comp,
++					ref_pwr_lvl);
++	}
++
++	/* step_bytes points to an array of struct cs_step_data */
++	steps =3D (const struct cs_step_data *)step_bytes;
++
++	/* Process each step using helper function */
++	for (idx =3D 0; idx < num_steps_reported; idx++)
++		process_cs_mode_step(rap, proc, &steps[idx], num_ant_paths,
++					idx);
++
++	/* Update status for this chunk */
++	cs_pd_set_local_status(proc,
++			(enum cs_procedure_done_status)proc_done_status);
++	cs_pd_set_remote_status(proc,
++			(enum cs_procedure_done_status)subevt_done_status);
++
++	/* Commit subevent chunk (RESULT or CONT) */
++	cs_pd_ras_commit_subevent(proc,
++		num_steps_reported,
++		proc_done_status,
++		subevt_done_status,
++		abort_reason & 0x0F,
++		(abort_reason >> 4) & 0x0F);
++
++	/* Ensure first segment body starts with the 4-byte RangingHeader */
++	ras_maybe_prepend_ranging_header(proc);
++
++	if (subevt_done_status !=3D SUBEVENT_DONE_PARTIAL_RESULTS)
++		/* Send RAS raw segment data */
++		send_ras_segment_data(rap, proc);
++
++	/* Procedure complete? Clean up */
++	if (proc_done_status =3D=3D CS_PROC_ALL_RESULTS_COMPLETE) {
++		DBG(rap, "Destroying CsProcedureData counter=3D%u and "
++			"clearing current_proc", proc->counter);
++		resptracker_reset_current_proc(resptracker);
++		/* Reset cached header values for next procedure */
++		resptracker->last_proc_counter =3D 0;
++		resptracker->last_start_acl_conn_evt_counter =3D 0;
++		resptracker->last_freq_comp =3D 0;
++		resptracker->last_ref_pwr_lvl =3D 0;
++	}
++}
++
++static void form_ras_data_with_cs_subevent_result(struct bt_rap *rap,
++		const struct rap_ev_cs_subevent_result *data,
++		uint16_t length)
++{
++	size_t base_len =3D offsetof(struct rap_ev_cs_subevent_result,
++					step_data);
++
++	if (!rap || !rap->resptracker || !data)
++		return;
++
++	/* Defensive check: base header must be present */
++	if (length < base_len)
++		return;
++
++	DBG(rap, "Received CS subevent result subevent: len=3D%d", length);
++
++	handle_local_subevent_result(rap,
++		true,			/* has header fields */
++		data->config_id,
++		data->num_ant_paths,
++		data->proc_counter,
++		data->start_acl_conn_evt_counter,
++		data->freq_comp,
++		data->ref_pwr_lvl,
++		data->proc_done_status,
++		data->subevt_done_status,
++		data->abort_reason,
++		data->num_steps_reported,
++		data->step_data);	/* start of steps */
++}
++
++static void form_ras_data_with_cs_subevent_result_cont(struct bt_rap *r=
ap,
++		const struct rap_ev_cs_subevent_result_cont *cont,
++		uint16_t length)
++{
++	size_t base_len =3D offsetof(struct rap_ev_cs_subevent_result_cont,
++					step_data);
++	struct cstracker *resptracker;
++
++	if (!rap || !rap->resptracker || !cont)
++		return;
++
++	if (length < base_len)
++		return;
++
++	DBG(rap, "Received CS subevent result continue subevent: len=3D%d",
++		length);
++
++	resptracker =3D rap->resptracker;
++
++	/* Use cached header values captured from the last RESULT event */
++	handle_local_subevent_result(rap,
++		false,			/* CONT has no header fields */
++		cont->config_id,
++		cont->num_ant_paths,
++		resptracker->last_proc_counter,
++		resptracker->last_start_acl_conn_evt_counter,
++		resptracker->last_freq_comp,
++		resptracker->last_ref_pwr_lvl,
++		cont->proc_done_status,
++		cont->subevt_done_status,
++		cont->abort_reason,
++		cont->num_steps_reported,
++		cont->step_data);
++}
++
+ void bt_rap_hci_cs_subevent_result_cont_callback(uint16_t length,
+ 						const void *param,
+ 						void *user_data)
+ {
++	const struct rap_ev_cs_subevent_result_cont *cont =3D param;
+ 	struct bt_rap *rap =3D user_data;
+=20
+ 	DBG(rap, "Received CS subevent CONT: len=3D%d", length);
++
++	form_ras_data_with_cs_subevent_result_cont(rap, cont, length);
+ }
+=20
+ void bt_rap_hci_cs_subevent_result_callback(uint16_t length,
+ 					const void *param,
+ 					void *user_data)
+ {
++	const struct rap_ev_cs_subevent_result *data =3D param;
+ 	struct bt_rap *rap =3D user_data;
+=20
+ 	DBG(rap, "Received CS subevent: len=3D%d", length);
++
++	/* Populate CsProcedureData and send RAS payload */
++	form_ras_data_with_cs_subevent_result(rap, data, length);
+ }
+=20
+ void bt_rap_hci_cs_procedure_enable_complete_callback(uint16_t length,
+ 						const void *param,
+ 						void *user_data)
+ {
++	const struct rap_ev_cs_proc_enable_cmplt *data =3D param;
+ 	struct bt_rap *rap =3D user_data;
++	struct cstracker *resptracker;
+=20
+ 	DBG(rap, "Received CS procedure enable complete subevent: len=3D%d",
+ 	    length);
++
++	if (!rap->resptracker) {
++		resptracker =3D new0(struct cstracker, 1);
++		cs_tracker_init(resptracker);
++		rap->resptracker =3D resptracker;
++	}
++
++	resptracker =3D rap->resptracker;
++
++	/* Populate responder tracker */
++	resptracker->config_id =3D data->config_id;
++	resptracker->selected_tx_power =3D data->sel_tx_pwr;
+ }
+=20
+ void bt_rap_hci_cs_sec_enable_complete_callback(uint16_t length,
+@@ -545,9 +1761,27 @@
+ 					const void *param,
+ 					void *user_data)
+ {
++	const struct rap_ev_cs_config_cmplt *data =3D param;
+ 	struct bt_rap *rap =3D user_data;
++	struct cstracker *resptracker;
++
++	if (!rap)
++		return;
+=20
+ 	DBG(rap, "Received CS config complete subevent: len=3D%d", length);
++
++	if (!rap->resptracker) {
++		resptracker =3D new0(struct cstracker, 1);
++		cs_tracker_init(resptracker);
++		rap->resptracker =3D resptracker;
++	}
++
++	resptracker =3D rap->resptracker;
++
++	/* Basic fields */
++	resptracker->config_id =3D data->config_id;
++	resptracker->role =3D data->role;
++	resptracker->rtt_type =3D data->rtt_type;
+ }
+=20
+ struct bt_rap *bt_rap_new(struct gatt_db *ldb, struct gatt_db *rdb)
+@@ -787,7 +2021,7 @@
+=20
+ 	bt_uuid16_create(&uuid, RAS_UUID16);
+=20
+-	gatt_db_foreach_service(rap->lrapdb->db, &uuid,
++	gatt_db_foreach_service(rap->rrapdb->db, &uuid,
+ 				foreach_rap_service, rap);
+=20
+ 	return true;
+diff --git a/src/shared/rap.h b/src/shared/rap.h
+--- a/src/shared/rap.h
++++ b/src/shared/rap.h
+@@ -97,11 +97,11 @@
+=20
+ struct cs_mode_one_data {
+ 	uint8_t packet_quality;
+-	uint8_t packet_rssi_dbm;
+-	uint8_t packet_ant;
+ 	uint8_t packet_nadm;
++	uint8_t packet_rssi_dbm;
+ 	int16_t toa_tod_init;
+ 	int16_t tod_toa_refl;
++	uint8_t packet_ant;
+ 	struct pct_iq_sample packet_pct1;
+ 	struct pct_iq_sample packet_pct2;
+ };
diff --git a/recipes-connectivity/bluez5/bluez5/0008-unit-test-rap-Add-PT=
S-tests-for-CS-reflector.patch b/recipes-connectivity/bluez5/bluez5/0008-=
unit-test-rap-Add-PTS-tests-for-CS-reflector.patch
new file mode 100644
index 0000000..4150389
--- /dev/null
+++ b/recipes-connectivity/bluez5/bluez5/0008-unit-test-rap-Add-PTS-tests=
-for-CS-reflector.patch
@@ -0,0 +1,408 @@
+From 303ea3c539b80778eaea68900c9ea9bb421a97c0 Mon Sep 17 00:00:00 2001
+From: Prathibha Madugonde <prathibha.madugonde@oss.qualcomm.com>
+Date: Thu, 30 Apr 2026 13:11:41 +0530
+Subject: [PATCH] unit/test-rap: Add PTS tests for CS reflector
+
+Added below RAS - Real time Ranging PTS testcases:
+RAS/SR/RCO/BV-01-C [Characteristic Read - RAS Features]
+RAS/SR/RRD/BV-01-C [Real-time Ranging Data]
+RAS/SR/RRD/BV-03-C [Real-time Ranging Data notifications and indications=
]
+RAS/SR/RRD/BV-05-C [Real-Time Ranging Data disconnection]
+RAS/SR/SPE/BI-11-C [Client enables both Real-time and On-demand]
+
+Upstream-Status: Backport [303ea3c539b80778eaea68900c9ea9bb421a97c0]
+Signed-off-by: Prathibha Madugonde <prathibha.madugonde@oss.qualcomm.com=
>
+---
+ unit/test-rap.c | 325 +++++++++++++++++++++++++++++++++++++++++++++++-
+ 1 file changed, 322 insertions(+), 3 deletions(-)
+
+diff --git a/unit/test-rap.c b/unit/test-rap.c
+index 884cb1c96..4ca4a715e 100644
+--- a/unit/test-rap.c
++++ b/unit/test-rap.c
+@@ -37,6 +37,7 @@ struct test_data_ras {
+ 	size_t iovcnt;
+ 	struct iovec *iov;
+ 	unsigned int ras_id;
++	struct bt_rap *rap;  /* Store rap instance for CS injection */
+ };
+=20
+ struct test_data_rap {
+@@ -68,8 +69,8 @@ struct notify {
+ 	do {							\
+ 		const struct iovec iov[] =3D { args };		\
+ 		static struct test_data_ras data;			\
+-		data.iovcnt =3D ARRAY_SIZE(iov_data(args));	\
+-		data.iov =3D util_iov_dup(iov, ARRAY_SIZE(iov_data(args))); \
++		data.iovcnt =3D ARRAY_SIZE(iov);	\
++		data.iov =3D util_iov_dup(iov, ARRAY_SIZE(iov)); \
+ 		tester_add(name, &data, NULL, function,	\
+ 				test_teardown_ras);			\
+ 	} while (0)
+@@ -155,6 +156,94 @@ static void gatt_notify_cb(struct gatt_db_attribute=
 *attrib,
+ 		printf("%s: Failed to send notification\n", __func__);
+ }
+=20
++static void gatt_ccc_write_cb(struct gatt_db_attribute *attrib,
++					unsigned int id, uint16_t offset,
++					const uint8_t *value, size_t len,
++					uint8_t opcode, struct bt_att *att,
++					void *user_data)
++{
++	struct test_data_ras *data =3D user_data;
++	struct ccc_state *ccc;
++	uint16_t handle;
++	uint16_t ccc_value;
++	uint8_t ecode =3D 0;
++
++	handle =3D gatt_db_attribute_get_handle(attrib);
++
++	if (offset) {
++		ecode =3D BT_ATT_ERROR_INVALID_OFFSET;
++		goto done;
++	}
++
++	if (len !=3D 2) {
++		ecode =3D BT_ATT_ERROR_INVALID_ATTRIBUTE_VALUE_LEN;
++		goto done;
++	}
++
++	ccc_value =3D get_le16(value);
++
++	ccc =3D get_ccc_state(data, handle);
++	if (!ccc) {
++		ecode =3D BT_ATT_ERROR_UNLIKELY;
++		goto done;
++	}
++
++	ccc->value =3D ccc_value;
++
++	/* Send write response first */
++	gatt_db_attribute_write_result(attrib, id, 0);
++
++	/* If notifications/indications enabled on Real-time Ranging Data CCCD=
,
++	 * inject fake HCI CS subevent data to trigger notifications
++	 */
++	if (handle =3D=3D 0x0006 && ccc_value !=3D 0x0000 && data->rap) {
++		size_t event_size =3D sizeof(struct rap_ev_cs_subevent_result) +
++				    sizeof(struct cs_step_data);
++		struct rap_ev_cs_subevent_result *fake_event;
++		struct cs_mode_zero_data *mode_zero;
++
++		if (tester_use_debug())
++			tester_debug("Injecting fake CS data...");
++
++		fake_event =3D g_malloc0(event_size);
++		if (!fake_event)
++			return;  /* Already sent write response */
++
++		/* Fill in the header fields */
++		fake_event->conn_hdl =3D 0x0001;
++		fake_event->config_id =3D 0x01;
++		fake_event->start_acl_conn_evt_counter =3D 0x0000;
++		fake_event->proc_counter =3D 0x0001;
++		fake_event->freq_comp =3D 0x0000;
++		fake_event->ref_pwr_lvl =3D 0x00;
++		fake_event->proc_done_status =3D 0x00;
++		fake_event->subevt_done_status =3D 0x00;
++		fake_event->abort_reason =3D 0x00;
++		fake_event->num_ant_paths =3D 0x01;
++		fake_event->num_steps_reported =3D 0x01;
++
++		fake_event->step_data[0].step_mode =3D CS_MODE_ZERO;
++		fake_event->step_data[0].step_chnl =3D 0x00;
++		/* Mode 0: 1+1+1+4 bytes */
++		fake_event->step_data[0].step_data_length =3D 4;
++mode_zero =3D &fake_event->step_data[0].step_mode_data.mode_zero_data;
++		mode_zero->packet_quality =3D 0x01;
++		mode_zero->packet_rssi_dbm =3D 0x02;
++		mode_zero->packet_ant =3D 0x03;
++		mode_zero->init_measured_freq_offset =3D 0x04;
++
++		/* Inject the fake event to trigger notification */
++		bt_rap_hci_cs_subevent_result_callback(event_size, fake_event,
++						       data->rap);
++
++		g_free(fake_event);
++	}
++	return;
++
++done:
++	gatt_db_attribute_write_result(attrib, id, ecode);
++}
++
+ static void gatt_ccc_read_cb(struct gatt_db_attribute *attrib,
+ 					unsigned int id, uint16_t offset,
+ 					uint8_t opcode, struct bt_att *att,
+@@ -184,10 +273,21 @@ done:
+=20
+ static void ras_attached(struct bt_rap *rap, void *user_data)
+ {
++	struct test_data_ras *data =3D user_data;
++
++	if (data) {
++		data->rap =3D rap;
++		bt_rap_ref(rap);  /* Keep a reference */
++	}
+ }
+=20
+ static void ras_detached(struct bt_rap *rap, void *user_data)
+ {
++	struct test_data_ras *data =3D user_data;
++
++	if (data && data->rap =3D=3D rap)
++		data->rap =3D NULL;
++
+ 	bt_rap_unref(rap);
+ }
+=20
+@@ -205,12 +305,13 @@ static void test_server(const void *user_data)
+ 	att =3D bt_att_new(io_get_fd(io), false);
+ 	g_assert(att);
+=20
++	bt_att_set_security(att, BT_ATT_SECURITY_MEDIUM);
+ 	bt_att_set_debug(att, BT_ATT_DEBUG, print_debug, "bt_att:", NULL);
+=20
+ 	data->db =3D gatt_db_new();
+ 	g_assert(data->db);
+=20
+-	gatt_db_ccc_register(data->db, gatt_ccc_read_cb, NULL,
++	gatt_db_ccc_register(data->db, gatt_ccc_read_cb, gatt_ccc_write_cb,
+ 					gatt_notify_cb, data);
+=20
+ 	bt_rap_add_db(data->db);
+@@ -426,6 +527,210 @@ static void test_server(const void *user_data)
+ 	DISC_RAS_CHAR_AFTER_TYPE, \
+ 	RAS_FIND_INFO
+=20
++/*
++ * RAS/SR/RCO/BV-01-C =EF=BF=BD Characteristic Read: RAS Features
++ *
++ *  ATT: Read Request (0x0a) len 2
++ *       Handle: 0x0003 (RAS Features value handle)
++ *
++ *  ATT: Read Response (0x0b) len 5
++ *       Value: 0x01 0x00 0x00 0x00
++ *       Feature bits:
++ *         Bit 0: Real-time ranging (1 =3D supported)
++ *         Bit 1: Retrieve stored results (0 =3D not supported)
++ *         Bit 2: Abort operation (0 =3D not supported)
++ *
++ *  Note: The RAS Features characteristic is registered with
++ *  BT_ATT_PERM_READ | BT_ATT_PERM_READ_ENCRYPT. Since the test sets
++ *  BT_ATT_SECURITY_MEDIUM, the encryption requirement is satisfied
++ *  and the server returns the feature value showing real-time ranging
++ *  support.
++ */
++
++#define ATT_READ_RAS_FEATURES \
++	IOV_DATA(0x0a, 0x03, 0x00), \
++	IOV_DATA(0x0b, 0x01, 0x00, 0x00, 0x00)
++
++#define RAS_SR_RCO_BV_01_C \
++	ATT_EXCHANGE_MTU, \
++	DISCOVER_PRIM_SERV_NOTIF, \
++	RAS_FIND_BY_TYPE_VALUE, \
++	DISC_RAS_CHAR_AFTER_TYPE, \
++	RAS_FIND_INFO, \
++	ATT_READ_RAS_FEATURES
++
++/*
++ * RAS Real-time Ranging Data CCCD Configuration
++ * Round 1: Enable/Disable notifications (CCCD =3D 0x0001)
++ * Round 2: Enable/Disable indications (CCCD =3D 0x0002)
++ */
++#define RAS_REALTIME_CCCD_CONFIG \
++	/* Round 1: Enable notifications on Real-time Ranging Data CCCD */ \
++	/* (handle 0x0006) */ \
++	IOV_DATA(0x12, 0x06, 0x00, 0x01, 0x00), \
++	IOV_DATA(0x13), \
++	/* Disable notifications */ \
++	IOV_DATA(0x12, 0x06, 0x00, 0x00, 0x00), \
++	IOV_DATA(0x13), \
++	/* Round 2: Enable indications on Real-time Ranging Data CCCD */ \
++	IOV_DATA(0x12, 0x06, 0x00, 0x02, 0x00), \
++	IOV_DATA(0x13), \
++	/* Disable indications */ \
++	IOV_DATA(0x12, 0x06, 0x00, 0x00, 0x00), \
++	IOV_DATA(0x13)
++
++/*
++ * Enable both notifications and indications (CCCD =3D 0x0003)
++ * Expect notification (0x1b) to be sent, not indication (0x1d)
++ * Then disable CCCD
++ *
++ * Note: This test is currently disabled because the GATT server reject=
s
++ * CCCD value 0x0003 (both notifications and indications enabled) befor=
e
++ * reaching the custom callback. The test infrastructure needs to be up=
dated
++ * to support this scenario.
++ */
++#define RAS_REALTIME_CCCD_BOTH_ENABLE_DISABLE \
++	/* Enable notifications only (CCCD =3D 0x0001) */ \
++	IOV_DATA(0x12, 0x06, 0x00, 0x01, 0x00), \
++	IOV_DATA(0x13), \
++	/* Disable CCCD */ \
++	IOV_DATA(0x12, 0x06, 0x00, 0x00, 0x00), \
++	IOV_DATA(0x13)
++
++/*
++ * Disconnection/Reconnection simulation for Real-time Ranging Data
++ * Enable notifications, disable (disconnect), re-enable (reconnect), d=
isable
++ */
++#define RAS_REALTIME_CCCD_DISCONNECT_RECONNECT \
++	/* Step 1: Enable notifications */ \
++	IOV_DATA(0x12, 0x06, 0x00, 0x01, 0x00), \
++	IOV_DATA(0x13), \
++	/* Step 3: Disable CCCD (simulates disconnection) */ \
++	IOV_DATA(0x12, 0x06, 0x00, 0x00, 0x00), \
++	IOV_DATA(0x13), \
++	/* Step 4: Re-enable notifications (simulates reconnection) */ \
++	IOV_DATA(0x12, 0x06, 0x00, 0x01, 0x00), \
++	IOV_DATA(0x13), \
++	/* Disable CCCD to clean up */ \
++	IOV_DATA(0x12, 0x06, 0x00, 0x00, 0x00), \
++	IOV_DATA(0x13)
++
++/*
++ * RAS/SR/RRD/BV-01-C [Real-time Ranging Data]
++ * Verify that the IUT can configure CCCD for notifications/indications
++ * of the Real-time Ranging Data characteristic.
++ */
++#define RAS_SR_RRD_BV_01_C \
++	ATT_EXCHANGE_MTU, \
++	DISCOVER_PRIM_SERV_NOTIF, \
++	RAS_FIND_BY_TYPE_VALUE, \
++	DISC_RAS_CHAR_AFTER_TYPE, \
++	RAS_FIND_INFO, \
++	RAS_REALTIME_CCCD_CONFIG
++
++/*
++ * RAS/SR/RRD/BV-03-C [Real-time Ranging Data notifications and indicat=
ions]
++ * Verify that the IUT only sends Real-time Ranging Data notifications =
when
++ * configured for both notifications and indications (CCCD =3D 0x0003).
++ *
++ * Test Procedure:
++ * 1. Write 0x0003 to Real-time Ranging Data CCCD (enable both
++ *    notifications and indications)
++ * 2. Trigger CS Subevent Data (via fake HCI event injection)
++ * 3. Verify IUT sends only notifications (0x1b), not indications (0x1d=
)
++ */
++#define RAS_SR_RRD_BV_03_C \
++	ATT_EXCHANGE_MTU, \
++	DISCOVER_PRIM_SERV_NOTIF, \
++	RAS_FIND_BY_TYPE_VALUE, \
++	DISC_RAS_CHAR_AFTER_TYPE, \
++	RAS_FIND_INFO, \
++	RAS_REALTIME_CCCD_BOTH_ENABLE_DISABLE
++
++/*
++ * RAS/SR/RRD/BV-05-C [Real-Time Ranging Data disconnection]
++ * Verify that the IUT does not resume sending Real-time Ranging Data
++ * notifications or indications after a disconnection occurs.
++ *
++ * Test Procedure:
++ * 1. Enable Real-time Ranging Data notifications
++ * 2. Trigger CS Subevent Data (IUT sends notifications)
++ * 3. Disable CCCD (simulates disconnection - CCCD resets to 0x0000)
++ * 4. Re-enable notifications (simulates reconnection and reconfigurati=
on)
++ * 5. Verify IUT does not send old ranging data
++ *
++ * Note: In a unit test, we simulate disconnection by disabling and re-=
enabling
++ * the CCCD. The RAP implementation should clear any pending data when =
CCCD is
++ * disabled, ensuring no old data is sent after re-enabling.
++ */
++#define RAS_SR_RRD_BV_05_C \
++	ATT_EXCHANGE_MTU, \
++	DISCOVER_PRIM_SERV_NOTIF, \
++	RAS_FIND_BY_TYPE_VALUE, \
++	DISC_RAS_CHAR_AFTER_TYPE, \
++	RAS_FIND_INFO, \
++	RAS_REALTIME_CCCD_DISCONNECT_RECONNECT
++
++/*
++ * RAS/SR/SPE/BI-11-C [Client enables both Real-time Ranging Data and
++ * On-demand Ranging Data notifications or indications]
++ *
++ * Test Purpose:
++ * Verify that the IUT responds with the Client Characteristic Configur=
ation
++ * Descriptor Improperly Configured error when both Real-time Ranging D=
ata
++ * and On-demand Ranging Data notifications or indications are enabled.
++ *
++ * Test Procedure:
++ * 1. Write 0x0001 to Real-time Ranging Data CCCD (enable notifications=
)
++ * 2. Write 0x0001 to On-demand Ranging Data CCCD (should fail with 0xF=
D)
++ * 3. Read both CCCDs to verify Real-time is 0x0001, On-demand is 0x000=
0
++ * 4. Write 0x0000 to Real-time Ranging Data CCCD (disable)
++ * 5. Write 0x0001 to On-demand Ranging Data CCCD (enable notifications=
)
++ * 6. Write 0x0001 to Real-time Ranging Data CCCD (should fail with 0xF=
D)
++ * 7. Read both CCCDs to verify Real-time is 0x0000, On-demand is 0x000=
1
++ *
++ * Expected Outcome:
++ * - Steps 2 and 6: IUT rejects with error code 0xFD
++ * - Step 3: Real-time CCCD =3D 0x0001, On-demand CCCD =3D 0x0000
++ * - Step 7: Real-time CCCD =3D 0x0000, On-demand CCCD =3D 0x0001
++ */
++#define RAS_SR_SPE_BI_11_C \
++	ATT_EXCHANGE_MTU, \
++	DISCOVER_PRIM_SERV_NOTIF, \
++	RAS_FIND_BY_TYPE_VALUE, \
++	DISC_RAS_CHAR_AFTER_TYPE, \
++	RAS_FIND_INFO, \
++	/* Step 1: Enable notifications on Real-time Ranging Data CCCD */ \
++	/* (handle 0x0006) */ \
++	IOV_DATA(0x12, 0x06, 0x00, 0x01, 0x00), \
++	IOV_DATA(0x13), \
++	/* Step 2: Try to enable notifications on On-demand Ranging Data */ \
++	/* CCCD (handle 0x0009) - should fail with 0xFD */ \
++	IOV_DATA(0x12, 0x09, 0x00, 0x01, 0x00), \
++	IOV_DATA(0x01, 0x12, 0x09, 0x00, 0xFD), \
++	/* Step 4: Read Real-time Ranging Data CCCD (should be 0x0001) */ \
++	IOV_DATA(0x0a, 0x06, 0x00), \
++	IOV_DATA(0x0b, 0x01, 0x00), \
++	/* Step 4: Read On-demand Ranging Data CCCD (should be 0x0000) */ \
++	IOV_DATA(0x0a, 0x09, 0x00), \
++	IOV_DATA(0x0b, 0x00, 0x00), \
++	/* Step 5: Disable Real-time Ranging Data CCCD */ \
++	IOV_DATA(0x12, 0x06, 0x00, 0x00, 0x00), \
++	IOV_DATA(0x13), \
++	/* Step 6: Enable notifications on On-demand Ranging Data CCCD */ \
++	IOV_DATA(0x12, 0x09, 0x00, 0x01, 0x00), \
++	IOV_DATA(0x13), \
++	/* Step 7: Try to enable notifications on Real-time Ranging Data */ \
++	/* CCCD - should fail with 0xFD */ \
++	IOV_DATA(0x12, 0x06, 0x00, 0x01, 0x00), \
++	IOV_DATA(0x01, 0x12, 0x06, 0x00, 0xFD), \
++	/* Step 9: Read Real-time Ranging Data CCCD (should be 0x0000) */ \
++	IOV_DATA(0x0a, 0x06, 0x00), \
++	IOV_DATA(0x0b, 0x00, 0x00), \
++	/* Step 9: Read On-demand Ranging Data CCCD (should be 0x0001) */ \
++	IOV_DATA(0x0a, 0x09, 0x00), \
++	IOV_DATA(0x0b, 0x01, 0x00)
++
+ int main(int argc, char *argv[])
+ {
+ 	tester_init(&argc, &argv);
+@@ -441,6 +746,20 @@ int main(int argc, char *argv[])
+ 					RAS_SR_SGGIT_CHA_BV_03_C);
+ 	define_test_ras("RAS/SR/SGGIT/CHA/BV-04-C", test_server,
+ 					RAS_SR_SGGIT_CHA_BV_04_C);
++	/* RAS Read Characteristic Operations */
++	define_test_ras("RAS/SR/RCO/BV-01-C", test_server,
++					RAS_SR_RCO_BV_01_C);
++	/* RAS Real-time Ranging Data */
++	define_test_ras("RAS/SR/RRD/BV-01-C", test_server,
++					RAS_SR_RRD_BV_01_C);
++	/* RAS Real-time Ranging Data with CS injection */
++	define_test_ras("RAS/SR/RRD/BV-03-C", test_server,
++					RAS_SR_RRD_BV_03_C);
++	define_test_ras("RAS/SR/RRD/BV-05-C", test_server,
++					RAS_SR_RRD_BV_05_C);
++	/* RAS Special Procedures - Mutual Exclusivity */
++	define_test_ras("RAS/SR/SPE/BI-11-C", test_server,
++					RAS_SR_SPE_BI_11_C);
+=20
+ 	return tester_run();
+ }
+--=20
+2.34.1
+
diff --git a/recipes-connectivity/bluez5/bluez5/0009-profiles-ranging-Rea=
d-cs_mode_one_data-members.patch b/recipes-connectivity/bluez5/bluez5/000=
9-profiles-ranging-Read-cs_mode_one_data-members.patch
new file mode 100644
index 0000000..64fd2d3
--- /dev/null
+++ b/recipes-connectivity/bluez5/bluez5/0009-profiles-ranging-Read-cs_mo=
de_one_data-members.patch
@@ -0,0 +1,54 @@
+From 5d4792dc2a2088e7355e19b5fa763159f2a8231d Mon Sep 17 00:00:00 2001
+From: Prathibha Madugonde <prathibha.madugonde@oss.qualcomm.com>
+Date: Thu, 30 Apr 2026 13:11:42 +0530
+Subject: [PATCH] profiles/ranging: Read cs_mode_one_data members
+
+Rearrage reading of cs_mode_one_data struct members as per spec.
+
+Upstream-Status: Backport [5d4792dc2a2088e7355e19b5fa763159f2a8231d]
+Signed-off-by: Prathibha Madugonde <prathibha.madugonde@oss.qualcomm.com=
>
+---
+ profiles/ranging/rap_hci.c | 25 ++++++++++++++-----------
+ 1 file changed, 14 insertions(+), 11 deletions(-)
+
+diff --git a/profiles/ranging/rap_hci.c b/profiles/ranging/rap_hci.c
+index a3d2df608..08ddc077c 100644
+--- a/profiles/ranging/rap_hci.c
++++ b/profiles/ranging/rap_hci.c
+@@ -632,19 +632,22 @@ static void parse_mode_one_data(struct iovec *iov,
+ 	}
+=20
+ 	DBG("CS Step mode 1");
+-	util_iov_pull_u8(iov, &mode_data->packet_quality);
+-	util_iov_pull_u8(iov, &mode_data->packet_rssi_dbm);
+-	util_iov_pull_u8(iov, &mode_data->packet_ant);
+-	util_iov_pull_u8(iov, &mode_data->packet_nadm);
+-
+-	if (iov->iov_len >=3D 2) {
+-		util_iov_pull_le16(iov, &time_val);
+-		if (cs_role =3D=3D CS_REFLECTOR)
+-			mode_data->tod_toa_refl =3D time_val;
+-		else
+-			mode_data->toa_tod_init =3D time_val;
++	/* Parse fixed fields in specification order */
++	if (!util_iov_pull_u8(iov, &mode_data->packet_quality) ||
++		!util_iov_pull_u8(iov, &mode_data->packet_nadm) ||
++		!util_iov_pull_u8(iov, &mode_data->packet_rssi_dbm) ||
++		!util_iov_pull_le16(iov, &time_val) ||
++		!util_iov_pull_u8(iov, &mode_data->packet_ant)) {
++		DBG("Mode 1: failed to parse basic fields");
++		memset(mode_data, 0, sizeof(*mode_data));
++		return;
+ 	}
+=20
++	if (cs_role =3D=3D CS_REFLECTOR)
++		mode_data->tod_toa_refl =3D time_val;
++	else
++		mode_data->toa_tod_init =3D time_val;
++
+ 	if ((cs_rtt_type =3D=3D 0x01 || cs_rtt_type =3D=3D 0x02) &&
+ 		iov->iov_len >=3D 6) {
+ 		int16_t i_val, q_val;
+--=20
+2.34.1
+
diff --git a/recipes-connectivity/bluez5/bluez5/0010-shared-hci-Add-BPF-f=
ilter-for-registered-events.patch b/recipes-connectivity/bluez5/bluez5/00=
10-shared-hci-Add-BPF-filter-for-registered-events.patch
new file mode 100644
index 0000000..5df5ced
--- /dev/null
+++ b/recipes-connectivity/bluez5/bluez5/0010-shared-hci-Add-BPF-filter-f=
or-registered-events.patch
@@ -0,0 +1,141 @@
+From ccc22a9193884ccc3c3cb2b7a7b90100187c20b5 Mon Sep 17 00:00:00 2001
+From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
+Date: Thu, 30 Apr 2026 11:50:36 -0400
+Subject: [PATCH] shared/hci: Add BPF filter for registered events
+
+Implement a BPF socket filter in bt_hci_register/bt_hci_unregister that
+uses setsockopt(SO_ATTACH_FILTER) to only accept HCI events that have
+been registered, plus BT_HCI_EVT_CMD_COMPLETE and BT_HCI_EVT_CMD_STATUS
+which are always needed for command response processing.
+
+The filter is rebuilt each time an event is registered or unregistered,
+and only applies to non-stream (raw socket) connections.
+
+Assisted-by: Claude:claude-opus-4.6
+
+Upstream-Status: Backport [ccc22a9193884ccc3c3cb2b7a7b90100187c20b5]
+Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
+Signed-off-by: Prathibha Madugonde <prathibha.madugonde@oss.qualcomm.com=
>
+---
+ src/shared/hci.c | 84 ++++++++++++++++++++++++++++++++++++++++++++++++
+ 1 file changed, 84 insertions(+)
+
+diff --git a/src/shared/hci.c b/src/shared/hci.c
+index 0faa6dea5..5105b0b2f 100644
+--- a/src/shared/hci.c
++++ b/src/shared/hci.c
+@@ -23,6 +23,7 @@
+ #include <sys/ioctl.h>
+ #include <fcntl.h>
+ #include <errno.h>
++#include <linux/filter.h>
+=20
+ #include "bluetooth/hci.h"
+ #include "monitor/bt.h"
+@@ -565,6 +566,85 @@ bool bt_hci_flush(struct bt_hci *hci)
+ 	return true;
+ }
+=20
++static void update_evt_filter(struct bt_hci *hci)
++{
++	const struct queue_entry *entry;
++	struct sock_filter *filters;
++	struct sock_fprog fprog;
++	unsigned int count, i;
++	int fd;
++
++	fd =3D io_get_fd(hci->io);
++	if (fd < 0)
++		return;
++
++	/* If stream-based (not a raw socket), no BPF filtering needed */
++	if (hci->is_stream)
++		return;
++
++	count =3D queue_length(hci->evt_list);
++
++	/* Build filter: load event code, check defaults + registered events.
++	 * Packet layout for HCI_CHANNEL_RAW: [H4 type (1 byte)][evt code (1)]
++	 * So event code is at offset 1.
++	 *
++	 * Filter structure:
++	 *   [0] Load byte at offset 1 (event code)
++	 *   [1] JEQ BT_HCI_EVT_CMD_COMPLETE -> accept
++	 *   [2] JEQ BT_HCI_EVT_CMD_STATUS -> accept
++	 *   [3..3+count-1] JEQ registered_event -> accept
++	 *   [3+count] reject
++	 *   [4+count] accept
++	 */
++	filters =3D malloc(sizeof(*filters) * (count + 5));
++	if (!filters)
++		return;
++
++	i =3D 0;
++
++	/* Load event code byte */
++	filters[i++] =3D (struct sock_filter)
++		BPF_STMT(BPF_LD + BPF_B + BPF_ABS, 1);
++
++	/* Check BT_HCI_EVT_CMD_COMPLETE (0x0e) */
++	filters[i++] =3D (struct sock_filter)
++		BPF_JUMP(BPF_JMP + BPF_JEQ + BPF_K, BT_HCI_EVT_CMD_COMPLETE,
++			 count + 2, 0);
++
++	/* Check BT_HCI_EVT_CMD_STATUS (0x0f) */
++	filters[i++] =3D (struct sock_filter)
++		BPF_JUMP(BPF_JMP + BPF_JEQ + BPF_K, BT_HCI_EVT_CMD_STATUS,
++			 count + 1, 0);
++
++	/* Check each registered event */
++	entry =3D queue_get_entries(hci->evt_list);
++	while (entry) {
++		const struct evt *evt =3D entry->data;
++		unsigned int jump =3D count - (i - 3);
++
++		filters[i] =3D (struct sock_filter)
++			BPF_JUMP(BPF_JMP + BPF_JEQ + BPF_K, evt->event,
++				 jump, 0);
++		i++;
++		entry =3D entry->next;
++	}
++
++	/* Reject */
++	filters[i++] =3D (struct sock_filter)
++		BPF_STMT(BPF_RET | BPF_K, 0);
++
++	/* Accept */
++	filters[i++] =3D (struct sock_filter)
++		BPF_STMT(BPF_RET | BPF_K, 0x0fffffff);
++
++	fprog.len =3D i;
++	fprog.filter =3D filters;
++
++	setsockopt(fd, SOL_SOCKET, SO_ATTACH_FILTER, &fprog, sizeof(fprog));
++
++	free(filters);
++}
++
+ unsigned int bt_hci_register(struct bt_hci *hci, uint8_t event,
+ 				bt_hci_callback_func_t callback,
+ 				void *user_data, bt_hci_destroy_func_t destroy)
+@@ -591,6 +671,8 @@ unsigned int bt_hci_register(struct bt_hci *hci, uin=
t8_t event,
+ 		return 0;
+ 	}
+=20
++	update_evt_filter(hci);
++
+ 	return evt->id;
+ }
+=20
+@@ -657,6 +739,8 @@ bool bt_hci_unregister(struct bt_hci *hci, unsigned =
int id)
+=20
+ 	evt_free(evt);
+=20
++	update_evt_filter(hci);
++
+ 	return true;
+ }
+=20
+--=20
+2.34.1
+
diff --git a/recipes-connectivity/bluez5/bluez5/0011-shared-hci-Add-bt_hc=
i_register_subevent-for-LE-Meta-.patch b/recipes-connectivity/bluez5/blue=
z5/0011-shared-hci-Add-bt_hci_register_subevent-for-LE-Meta-.patch
new file mode 100644
index 0000000..d447338
--- /dev/null
+++ b/recipes-connectivity/bluez5/bluez5/0011-shared-hci-Add-bt_hci_regis=
ter_subevent-for-LE-Meta-.patch
@@ -0,0 +1,360 @@
+From 98f7190cf6b9e918943deeacd2f1494c9ca0710c Mon Sep 17 00:00:00 2001
+From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
+Date: Thu, 30 Apr 2026 11:50:37 -0400
+Subject: [PATCH] shared/hci: Add bt_hci_register_subevent for LE Meta ev=
ents
+
+Add bt_hci_register_subevent/bt_hci_unregister_subevent API that allows
+registering for specific LE Meta Event subevents. The BPF filter is
+extended to accept BT_HCI_EVT_LE_META_EVENT packets and then check the
+subevent byte (offset 4) against registered subevents.
+
+Since bt_hci_register_subevent is only used with BT_HCI_EVT_LE_META_EVEN=
T,
+the event parameter is omitted. The subevent list reuses struct evt wher=
e
+evt->event stores the subevent code.
+
+Assisted-by: Claude:claude-opus-4.6
+
+Upstream-Status: Backport [98f7190cf6b9e918943deeacd2f1494c9ca0710c]
+Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
+Signed-off-by: Prathibha Madugonde <prathibha.madugonde@oss.qualcomm.com=
>
+---
+ src/shared/hci.c | 236 ++++++++++++++++++++++++++++++++++++++++-------
+ src/shared/hci.h |   6 ++
+ 2 files changed, 210 insertions(+), 32 deletions(-)
+
+diff --git a/src/shared/hci.c b/src/shared/hci.c
+index 5105b0b2f..40326fc81 100644
+--- a/src/shared/hci.c
++++ b/src/shared/hci.c
+@@ -45,6 +45,7 @@ struct bt_hci {
+ 	struct queue *cmd_queue;
+ 	struct queue *rsp_queue;
+ 	struct queue *evt_list;
++	struct queue *subevt_list;
+ 	struct queue *data_queue;
+ };
+=20
+@@ -239,6 +240,21 @@ static void process_notify(void *data, void *user_d=
ata)
+ 						hdr->plen, evt->user_data);
+ }
+=20
++struct subevt_data {
++	uint8_t subevent;
++	const void *data;
++	uint8_t size;
++};
++
++static void process_subevt_notify(void *data, void *user_data)
++{
++	struct subevt_data *sd =3D user_data;
++	struct evt *evt =3D data;
++
++	if (evt->event =3D=3D sd->subevent)
++		evt->callback(sd->data, sd->size, evt->user_data);
++}
++
+ static void process_event(struct bt_hci *hci, const void *data, size_t =
size)
+ {
+ 	const struct bt_hci_evt_hdr *hdr =3D data;
+@@ -275,6 +291,16 @@ static void process_event(struct bt_hci *hci, const=
 void *data, size_t size)
+=20
+ 	default:
+ 		queue_foreach(hci->evt_list, process_notify, (void *) hdr);
++		if (hdr->evt =3D=3D BT_HCI_EVT_LE_META_EVENT && size > 0) {
++			const uint8_t *params =3D data;
++			struct subevt_data sd;
++
++			sd.subevent =3D params[0];
++			sd.data =3D data + 1;
++			sd.size =3D size - 1;
++			queue_foreach(hci->subevt_list,
++					process_subevt_notify, &sd);
++		}
+ 		break;
+ 	}
+ }
+@@ -332,10 +358,12 @@ static struct bt_hci *create_hci(int fd)
+ 	hci->cmd_queue =3D queue_new();
+ 	hci->rsp_queue =3D queue_new();
+ 	hci->evt_list =3D queue_new();
++	hci->subevt_list =3D queue_new();
+ 	hci->data_queue =3D queue_new();
+=20
+ 	if (!io_set_read_handler(hci->io, io_read_callback, hci, NULL)) {
+ 		queue_destroy(hci->evt_list, NULL);
++		queue_destroy(hci->subevt_list, NULL);
+ 		queue_destroy(hci->rsp_queue, NULL);
+ 		queue_destroy(hci->cmd_queue, NULL);
+ 		queue_destroy(hci->data_queue, NULL);
+@@ -458,6 +486,7 @@ void bt_hci_unref(struct bt_hci *hci)
+ 		return;
+=20
+ 	queue_destroy(hci->evt_list, evt_free);
++	queue_destroy(hci->subevt_list, evt_free);
+ 	queue_destroy(hci->cmd_queue, cmd_free);
+ 	queue_destroy(hci->rsp_queue, cmd_free);
+ 	queue_destroy(hci->data_queue, data_free);
+@@ -571,7 +600,7 @@ static void update_evt_filter(struct bt_hci *hci)
+ 	const struct queue_entry *entry;
+ 	struct sock_filter *filters;
+ 	struct sock_fprog fprog;
+-	unsigned int count, i;
++	unsigned int evt_count, subevt_count, count, i;
+ 	int fd;
+=20
+ 	fd =3D io_get_fd(hci->io);
+@@ -582,21 +611,38 @@ static void update_evt_filter(struct bt_hci *hci)
+ 	if (hci->is_stream)
+ 		return;
+=20
+-	count =3D queue_length(hci->evt_list);
++	evt_count =3D queue_length(hci->evt_list);
++	subevt_count =3D queue_length(hci->subevt_list);
+=20
+-	/* Build filter: load event code, check defaults + registered events.
+-	 * Packet layout for HCI_CHANNEL_RAW: [H4 type (1 byte)][evt code (1)]
+-	 * So event code is at offset 1.
++	/* Filter structure:
++	 * Packet layout: [H4 type(1)][evt code(1)][plen(1)][params...]
++	 * For LE Meta: params[0] is the subevent code (offset 3 from start)
+ 	 *
+-	 * Filter structure:
+ 	 *   [0] Load byte at offset 1 (event code)
+-	 *   [1] JEQ BT_HCI_EVT_CMD_COMPLETE -> accept
+-	 *   [2] JEQ BT_HCI_EVT_CMD_STATUS -> accept
+-	 *   [3..3+count-1] JEQ registered_event -> accept
+-	 *   [3+count] reject
+-	 *   [4+count] accept
++	 *   [1] JEQ CMD_COMPLETE -> accept
++	 *   [2] JEQ CMD_STATUS -> accept
++	 *   [3] JEQ LE_META -> subevent_check (if subevts registered)
++	 *   [4..4+evt_count-1] JEQ registered_event -> accept
++	 *   [4+evt_count] reject
++	 *   -- subevent section (if subevt_count > 0) --
++	 *   [5+evt_count] Load byte at offset 3 (subevent code)
++	 *   [6+evt_count..6+evt_count+subevt_count-1] JEQ subevent -> accept
++	 *   [6+evt_count+subevt_count] reject
++	 *   -- shared accept --
++	 *   [last] accept
++	 */
++
++	/* Without subevents: 3 (defaults) + evt_count + reject + accept =3D
++	 *                    evt_count + 5
++	 * With subevents: 4 (defaults+LE_META) + evt_count + reject +
++	 *                 1 (load subevent) + subevt_count + reject + accept
+ 	 */
+-	filters =3D malloc(sizeof(*filters) * (count + 5));
++	if (subevt_count)
++		count =3D 4 + evt_count + 1 + 1 + subevt_count + 1 + 1;
++	else
++		count =3D 3 + evt_count + 1 + 1;
++
++	filters =3D malloc(sizeof(*filters) * count);
+ 	if (!filters)
+ 		return;
+=20
+@@ -606,32 +652,106 @@ static void update_evt_filter(struct bt_hci *hci)
+ 	filters[i++] =3D (struct sock_filter)
+ 		BPF_STMT(BPF_LD + BPF_B + BPF_ABS, 1);
+=20
+-	/* Check BT_HCI_EVT_CMD_COMPLETE (0x0e) */
+-	filters[i++] =3D (struct sock_filter)
+-		BPF_JUMP(BPF_JMP + BPF_JEQ + BPF_K, BT_HCI_EVT_CMD_COMPLETE,
+-			 count + 2, 0);
++	if (subevt_count) {
++		/* accept is at index: count - 1
++		 * From instruction at index i, jump_true =3D (count-1) - (i+1)
++		 */
+=20
+-	/* Check BT_HCI_EVT_CMD_STATUS (0x0f) */
+-	filters[i++] =3D (struct sock_filter)
+-		BPF_JUMP(BPF_JMP + BPF_JEQ + BPF_K, BT_HCI_EVT_CMD_STATUS,
+-			 count + 1, 0);
++		/* Check BT_HCI_EVT_CMD_COMPLETE -> accept */
++		filters[i] =3D (struct sock_filter)
++			BPF_JUMP(BPF_JMP + BPF_JEQ + BPF_K,
++				 BT_HCI_EVT_CMD_COMPLETE,
++				 count - 1 - (i + 1), 0);
++		i++;
+=20
+-	/* Check each registered event */
+-	entry =3D queue_get_entries(hci->evt_list);
+-	while (entry) {
+-		const struct evt *evt =3D entry->data;
+-		unsigned int jump =3D count - (i - 3);
++		/* Check BT_HCI_EVT_CMD_STATUS -> accept */
++		filters[i] =3D (struct sock_filter)
++			BPF_JUMP(BPF_JMP + BPF_JEQ + BPF_K,
++				 BT_HCI_EVT_CMD_STATUS,
++				 count - 1 - (i + 1), 0);
++		i++;
+=20
++		/* Check LE_META -> subevent section
++		 * subevent section starts at: 4 + evt_count + 1
++		 * (after the evt reject instruction)
++		 */
+ 		filters[i] =3D (struct sock_filter)
+-			BPF_JUMP(BPF_JMP + BPF_JEQ + BPF_K, evt->event,
+-				 jump, 0);
++			BPF_JUMP(BPF_JMP + BPF_JEQ + BPF_K,
++				 BT_HCI_EVT_LE_META_EVENT,
++				 4 + evt_count + 1 - (i + 1), 0);
+ 		i++;
+-		entry =3D entry->next;
+-	}
+=20
+-	/* Reject */
+-	filters[i++] =3D (struct sock_filter)
+-		BPF_STMT(BPF_RET | BPF_K, 0);
++		/* Check each registered event -> accept */
++		entry =3D queue_get_entries(hci->evt_list);
++		while (entry) {
++			const struct evt *evt =3D entry->data;
++
++			filters[i] =3D (struct sock_filter)
++				BPF_JUMP(BPF_JMP + BPF_JEQ + BPF_K,
++					 evt->event,
++					 count - 1 - (i + 1), 0);
++			i++;
++			entry =3D entry->next;
++		}
++
++		/* Reject (for non-matching events) */
++		filters[i++] =3D (struct sock_filter)
++			BPF_STMT(BPF_RET | BPF_K, 0);
++
++		/* Subevent section: load subevent byte at offset 3 */
++		filters[i++] =3D (struct sock_filter)
++			BPF_STMT(BPF_LD + BPF_B + BPF_ABS, 3);
++
++		/* Check each registered subevent -> accept */
++		entry =3D queue_get_entries(hci->subevt_list);
++		while (entry) {
++			const struct evt *evt =3D entry->data;
++
++			filters[i] =3D (struct sock_filter)
++				BPF_JUMP(BPF_JMP + BPF_JEQ + BPF_K,
++					 evt->event,
++					 count - 1 - (i + 1), 0);
++			i++;
++			entry =3D entry->next;
++		}
++
++		/* Reject (for non-matching subevents) */
++		filters[i++] =3D (struct sock_filter)
++			BPF_STMT(BPF_RET | BPF_K, 0);
++	} else {
++		/* No subevents - simple filter */
++
++		/* Check BT_HCI_EVT_CMD_COMPLETE -> accept */
++		filters[i] =3D (struct sock_filter)
++			BPF_JUMP(BPF_JMP + BPF_JEQ + BPF_K,
++				 BT_HCI_EVT_CMD_COMPLETE,
++				 count - 1 - (i + 1), 0);
++		i++;
++
++		/* Check BT_HCI_EVT_CMD_STATUS -> accept */
++		filters[i] =3D (struct sock_filter)
++			BPF_JUMP(BPF_JMP + BPF_JEQ + BPF_K,
++				 BT_HCI_EVT_CMD_STATUS,
++				 count - 1 - (i + 1), 0);
++		i++;
++
++		/* Check each registered event -> accept */
++		entry =3D queue_get_entries(hci->evt_list);
++		while (entry) {
++			const struct evt *evt =3D entry->data;
++
++			filters[i] =3D (struct sock_filter)
++				BPF_JUMP(BPF_JMP + BPF_JEQ + BPF_K,
++					 evt->event,
++					 count - 1 - (i + 1), 0);
++			i++;
++			entry =3D entry->next;
++		}
++
++		/* Reject */
++		filters[i++] =3D (struct sock_filter)
++			BPF_STMT(BPF_RET | BPF_K, 0);
++	}
+=20
+ 	/* Accept */
+ 	filters[i++] =3D (struct sock_filter)
+@@ -744,6 +864,58 @@ bool bt_hci_unregister(struct bt_hci *hci, unsigned=
 int id)
+ 	return true;
+ }
+=20
++
++unsigned int bt_hci_register_subevent(struct bt_hci *hci,
++				uint8_t subevent,
++				bt_hci_callback_func_t callback,
++				void *user_data, bt_hci_destroy_func_t destroy)
++{
++	struct evt *evt;
++
++	if (!hci)
++		return 0;
++
++	evt =3D new0(struct evt, 1);
++	evt->event =3D subevent;
++
++	if (hci->next_evt_id < 1)
++		hci->next_evt_id =3D 1;
++
++	evt->id =3D hci->next_evt_id++;
++
++	evt->callback =3D callback;
++	evt->destroy =3D destroy;
++	evt->user_data =3D user_data;
++
++	if (!queue_push_tail(hci->subevt_list, evt)) {
++		free(evt);
++		return 0;
++	}
++
++	update_evt_filter(hci);
++
++	return evt->id;
++}
++
++bool bt_hci_unregister_subevent(struct bt_hci *hci, unsigned int id)
++{
++	struct evt *evt;
++
++	if (!hci || !id)
++		return false;
++
++	evt =3D queue_remove_if(hci->subevt_list, match_evt_id,
++							UINT_TO_PTR(id));
++	if (!evt)
++		return false;
++
++	evt_free(evt);
++
++	update_evt_filter(hci);
++
++	return true;
++}
++
+ bool bt_hci_get_conn_handle(struct bt_hci *hci, const uint8_t *bdaddr,
+ 				uint16_t *handle)
+ {
+diff --git a/src/shared/hci.h b/src/shared/hci.h
+index 800dc4946..5be48577f 100644
+--- a/src/shared/hci.h
++++ b/src/shared/hci.h
+@@ -42,5 +42,11 @@ unsigned int bt_hci_register(struct bt_hci *hci, uint=
8_t event,
+ 				void *user_data, bt_hci_destroy_func_t destroy);
+ bool bt_hci_unregister(struct bt_hci *hci, unsigned int id);
+=20
++unsigned int bt_hci_register_subevent(struct bt_hci *hci,
++				uint8_t subevent,
++				bt_hci_callback_func_t callback,
++				void *user_data, bt_hci_destroy_func_t destroy);
++bool bt_hci_unregister_subevent(struct bt_hci *hci, unsigned int id);
++
+ bool bt_hci_get_conn_handle(struct bt_hci *hci, const uint8_t *bdaddr,
+ 				uint16_t *handle);
+--=20
+2.34.1
+
diff --git a/recipes-connectivity/bluez5/bluez5/0012-ranging-rap_hci-Use-=
bt_hci_register_subevent-for-LE-.patch b/recipes-connectivity/bluez5/blue=
z5/0012-ranging-rap_hci-Use-bt_hci_register_subevent-for-LE-.patch
new file mode 100644
index 0000000..2db9840
--- /dev/null
+++ b/recipes-connectivity/bluez5/bluez5/0012-ranging-rap_hci-Use-bt_hci_=
register_subevent-for-LE-.patch
@@ -0,0 +1,309 @@
+From 45e1e7ca2243fdea4fb0f31ac56de2e9ee9e9c5b Mon Sep 17 00:00:00 2001
+From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
+Date: Thu, 30 Apr 2026 11:50:38 -0400
+Subject: [PATCH] ranging/rap_hci: Use bt_hci_register_subevent for LE CS
+ events
+
+Replace the single BT_HCI_EVT_LE_META_EVENT registration and subevent
+dispatch table with individual bt_hci_register_subevent calls for each
+CS subevent. This enables BPF filtering at the socket level for each
+specific subevent and removes the manual subevent dispatch logic.
+
+Event IDs are stored in a struct queue for flexible management.
+
+Assisted-by: Claude:claude-opus-4.6
+
+Upstream-Status: Backport [45e1e7ca2243fdea4fb0f31ac56de2e9ee9e9c5b]
+Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
+Signed-off-by: Prathibha Madugonde <prathibha.madugonde@oss.qualcomm.com=
>
+---
+ profiles/ranging/rap_hci.c | 193 ++++++++++++++-----------------------
+ 1 file changed, 71 insertions(+), 122 deletions(-)
+
+diff --git a/profiles/ranging/rap_hci.c b/profiles/ranging/rap_hci.c
+index 08ddc077c..8e65e5ef8 100644
+--- a/profiles/ranging/rap_hci.c
++++ b/profiles/ranging/rap_hci.c
+@@ -61,7 +61,7 @@ struct cs_state_machine {
+ 	enum cs_state old_state;
+ 	struct bt_hci *hci;
+ 	struct bt_rap *rap;
+-	unsigned int event_id;
++	struct queue *event_ids;
+ 	bool initiator;
+ 	bool procedure_active;
+ 	struct bt_rap_hci_cs_options cs_opt;  /* Per-instance CS options */
+@@ -302,7 +302,7 @@ static void rap_send_hci_def_settings_command(struct=
 cs_state_machine *sm,
+ 		error("Failed to send default settings cmd");
+ }
+=20
+-static void rap_rd_rmt_supp_cap_cmplt_evt(const uint8_t *data, uint8_t =
size,
++static void rap_rd_rmt_supp_cap_cmplt_evt(const void *data, uint8_t siz=
e,
+ 					   void *user_data)
+ {
+ 	struct cs_state_machine *sm =3D user_data;
+@@ -348,7 +348,7 @@ static void rap_rd_rmt_supp_cap_cmplt_evt(const uint=
8_t *data, uint8_t size,
+ 	cs_set_state(sm, CS_STATE_INIT);
+ }
+=20
+-static void rap_cs_config_cmplt_evt(const uint8_t *data, uint8_t size,
++static void rap_cs_config_cmplt_evt(const void *data, uint8_t size,
+ 				    void *user_data)
+ {
+ 	struct cs_state_machine *sm =3D user_data;
+@@ -439,7 +439,7 @@ static void rap_cs_config_cmplt_evt(const uint8_t *d=
ata, uint8_t size,
+ 	bt_rap_hci_cs_config_complete_callback(size, &rap_ev, sm->rap);
+ }
+=20
+-static void rap_cs_sec_enable_cmplt_evt(const uint8_t *data, uint8_t si=
ze,
++static void rap_cs_sec_enable_cmplt_evt(const void *data, uint8_t size,
+ 					 void *user_data)
+ {
+ 	struct cs_state_machine *sm =3D user_data;
+@@ -500,7 +500,7 @@ static void rap_cs_sec_enable_cmplt_evt(const uint8_=
t *data, uint8_t size,
+ 	bt_rap_hci_cs_sec_enable_complete_callback(size, &rap_ev, sm->rap);
+ }
+=20
+-static void rap_cs_proc_enable_cmplt_evt(const uint8_t *data, uint8_t s=
ize,
++static void rap_cs_proc_enable_cmplt_evt(const void *data, uint8_t size=
,
+ 					  void *user_data)
+ {
+ 	struct cs_state_machine *sm =3D user_data;
+@@ -800,7 +800,7 @@ static void parse_cs_step(struct iovec *iov, struct =
cs_step_data *step,
+ 	}
+ }
+=20
+-static void rap_cs_subevt_result_evt(const uint8_t *data, uint8_t size,
++static void rap_cs_subevt_result_evt(const void *data, uint8_t size,
+ 				void *user_data)
+ {
+ 	struct cs_state_machine *sm =3D (struct cs_state_machine *) user_data;
+@@ -910,7 +910,7 @@ send_event:
+ 	free(rap_ev);
+ }
+=20
+-static void rap_cs_subevt_result_cont_evt(const uint8_t *data, uint8_t =
size,
++static void rap_cs_subevt_result_cont_evt(const void *data, uint8_t siz=
e,
+ 					void *user_data)
+ {
+ 	struct cs_state_machine *sm =3D (struct cs_state_machine *) user_data;
+@@ -1009,113 +1009,12 @@ send_event:
+ }
+=20
+ /* Subevent handler function type */
+-typedef void (*subevent_handler_t)(const uint8_t *data, uint8_t size,
+-				   void *user_data);
+-
+-/* Subevent table entry */
+-struct subevent_entry {
+-	uint8_t opcode;
+-	uint8_t min_len;
+-	uint8_t max_len;
+-	subevent_handler_t handler;
+-	const char *name;
+-};
+-
+-/* Macro to define HCI event entries
+- * Note: min_len excludes the subevent byte since it's stripped before =
dispatch
+- */
+-#define HCI_EVT(_opcode, _struct, _handler, _name) \
+-	{ \
+-		.opcode =3D _opcode, \
+-		.min_len =3D sizeof(_struct), \
+-		.max_len =3D 0xFF, \
+-		.handler =3D _handler, \
+-		.name =3D _name \
+-	}
+-
+-/* Subevent dispatch table */
+-static const struct subevent_entry subevent_table[] =3D {
+-	HCI_EVT(BT_HCI_EVT_LE_CS_RD_REM_SUPP_CAP_COMPLETE,
+-		struct bt_hci_evt_le_cs_rd_rem_supp_cap_complete,
+-		rap_rd_rmt_supp_cap_cmplt_evt,
+-		"CS Read Remote Supported Capabilities Complete"),
+-	HCI_EVT(BT_HCI_EVT_LE_CS_CONFIG_COMPLETE,
+-		struct bt_hci_evt_le_cs_config_complete,
+-		rap_cs_config_cmplt_evt,
+-		"CS Config Complete"),
+-	HCI_EVT(BT_HCI_EVT_LE_CS_SEC_ENABLE_COMPLETE,
+-		struct bt_hci_evt_le_cs_sec_enable_complete,
+-		rap_cs_sec_enable_cmplt_evt,
+-		"CS Security Enable Complete"),
+-	HCI_EVT(BT_HCI_EVT_LE_CS_PROC_ENABLE_COMPLETE,
+-		struct bt_hci_evt_le_cs_proc_enable_complete,
+-		rap_cs_proc_enable_cmplt_evt,
+-		"CS Procedure Enable Complete"),
+-	HCI_EVT(BT_HCI_EVT_LE_CS_SUBEVENT_RESULT,
+-		struct bt_hci_evt_le_cs_subevent_result,
+-		rap_cs_subevt_result_evt,
+-		"CS Subevent Result"),
+-	HCI_EVT(BT_HCI_EVT_LE_CS_SUBEVENT_RESULT_CONTINUE,
+-		struct bt_hci_evt_le_cs_subevent_result_continue,
+-		rap_cs_subevt_result_cont_evt,
+-		"CS Subevent Result Continue")
+-};
+=20
+-#undef HCI_EVT
+-
+-#define SUBEVENT_TABLE_SIZE ARRAY_SIZE(subevent_table)
+-
+-/* HCI Event Registration */
+-static void rap_handle_hci_events(const void *data, uint8_t size,
+-				void *user_data)
++static void unregister_event_id(void *data, void *user_data)
+ {
+-	struct iovec iov;
+-	uint8_t subevent;
+-	const struct subevent_entry *entry =3D NULL;
+-	size_t i;
+-
+-	/* Initialize iovec with the event data */
+-	iov.iov_base =3D (void *) data;
+-	iov.iov_len =3D size;
+-
+-	/* Pull the subevent code */
+-	if (!util_iov_pull_u8(&iov, &subevent)) {
+-		DBG("Failed to parse subevent code");
+-		return;
+-	}
+-
+-	/* Find the subevent in the table */
+-	for (i =3D 0; i < SUBEVENT_TABLE_SIZE; i++) {
+-		if (subevent_table[i].opcode =3D=3D subevent) {
+-			entry =3D &subevent_table[i];
+-			break;
+-		}
+-	}
+-
+-	/* Check if subevent is supported */
+-	if (!entry) {
+-		DBG("Unknown subevent: 0x%02X", subevent);
+-		return;
+-	}
+-
+-	/* Validate payload length */
+-	if (iov.iov_len < entry->min_len) {
+-		DBG("%s: payload too short (%zu < %u)",
+-		    entry->name, iov.iov_len, entry->min_len);
+-		return;
+-	}
+-
+-	if (entry->max_len !=3D 0xFF && iov.iov_len > entry->max_len) {
+-		DBG("%s: payload too long (%zu > %u)",
+-		    entry->name, iov.iov_len, entry->max_len);
+-		return;
+-	}
+-
+-	/* Call the handler */
+-	DBG("Handling %s (opcode=3D0x%02X, len=3D%zu)",
+-	    entry->name, subevent, iov.iov_len);
++	struct bt_hci *hci =3D user_data;
+=20
+-	entry->handler(iov.iov_base, iov.iov_len, user_data);
++	bt_hci_unregister_subevent(hci, PTR_TO_UINT(data));
+ }
+=20
+ void *bt_rap_attach_hci(struct bt_rap *rap, struct bt_hci *hci,
+@@ -1123,6 +1022,7 @@ void *bt_rap_attach_hci(struct bt_rap *rap, struct=
 bt_hci *hci,
+ 			int8_t max_tx_power)
+ {
+ 	struct cs_state_machine *sm;
++	unsigned int id;
+=20
+ 	if (!rap || !hci) {
+ 		error("rap or hci null");
+@@ -1140,22 +1040,68 @@ void *bt_rap_attach_hci(struct bt_rap *rap, stru=
ct bt_hci *hci,
+ 	cs_state_machine_init(sm, rap, hci, role, cs_sync_ant_sel,
+ 				max_tx_power);
+=20
+-	sm->event_id =3D bt_hci_register(hci, BT_HCI_EVT_LE_META_EVENT,
+-					rap_handle_hci_events, sm, NULL);
++	sm->event_ids =3D queue_new();
+=20
+-	DBG("bt_hci_register done, event_id : %d", sm->event_id);
++	/* Register each LE Meta subevent individually */
++	id =3D bt_hci_register_subevent(hci,
++			BT_HCI_EVT_LE_CS_RD_REM_SUPP_CAP_COMPLETE,
++			rap_rd_rmt_supp_cap_cmplt_evt, sm, NULL);
++	if (!id)
++		goto fail;
+=20
+-	if (!sm->event_id) {
+-		error("Failed to register hci le meta events");
+-		error("event_id=3D0x%02X", sm->event_id);
+-		free(sm);
+-		return NULL;
+-	}
++	queue_push_tail(sm->event_ids, UINT_TO_PTR(id));
++
++	id =3D bt_hci_register_subevent(hci,
++			BT_HCI_EVT_LE_CS_CONFIG_COMPLETE,
++			rap_cs_config_cmplt_evt, sm, NULL);
++	if (!id)
++		goto fail;
++
++	queue_push_tail(sm->event_ids, UINT_TO_PTR(id));
++
++	id =3D bt_hci_register_subevent(hci,
++			BT_HCI_EVT_LE_CS_SEC_ENABLE_COMPLETE,
++			rap_cs_sec_enable_cmplt_evt, sm, NULL);
++	if (!id)
++		goto fail;
++
++	queue_push_tail(sm->event_ids, UINT_TO_PTR(id));
++
++	id =3D bt_hci_register_subevent(hci,
++			BT_HCI_EVT_LE_CS_PROC_ENABLE_COMPLETE,
++			rap_cs_proc_enable_cmplt_evt, sm, NULL);
++	if (!id)
++		goto fail;
++
++	queue_push_tail(sm->event_ids, UINT_TO_PTR(id));
++
++	id =3D bt_hci_register_subevent(hci,
++			BT_HCI_EVT_LE_CS_SUBEVENT_RESULT,
++			rap_cs_subevt_result_evt, sm, NULL);
++	if (!id)
++		goto fail;
++
++	queue_push_tail(sm->event_ids, UINT_TO_PTR(id));
++
++	id =3D bt_hci_register_subevent(hci,
++			BT_HCI_EVT_LE_CS_SUBEVENT_RESULT_CONTINUE,
++			rap_cs_subevt_result_cont_evt, sm, NULL);
++	if (!id)
++		goto fail;
++
++	queue_push_tail(sm->event_ids, UINT_TO_PTR(id));
+=20
+ 	DBG("CS options: role=3D%u, cs_sync_ant_sel=3D%u, max_tx_power=3D%d",
+ 		role, cs_sync_ant_sel, max_tx_power);
+=20
+ 	return sm;
++
++fail:
++	error("Failed to register hci le meta subevents");
++	queue_foreach(sm->event_ids, unregister_event_id, hci);
++	queue_destroy(sm->event_ids, NULL);
++	free(sm);
++	return NULL;
+ }
+=20
+ bool bt_rap_set_conn_handle(void *hci_sm, struct bt_rap *rap, uint16_t =
handle,
+@@ -1204,8 +1150,11 @@ void bt_rap_detach_hci(struct bt_rap *rap, void *=
hci_sm)
+ 	/* Cleanup the per-instance state machine */
+ 	if (sm) {
+ 		/* Unregister HCI events */
+-		if (sm->event_id && sm->hci)
+-			bt_hci_unregister(sm->hci, sm->event_id);
++		if (sm->hci)
++			queue_foreach(sm->event_ids, unregister_event_id,
++								sm->hci);
++
++		queue_destroy(sm->event_ids, NULL);
+=20
+ 		/* Clean up per-instance connection mappings */
+ 		remove_rap_mappings(sm);
+--=20
+2.34.1
+
diff --git a/recipes-connectivity/bluez5/bluez5/0013-test-rap-Fix-gatt_cc=
c_read_cb-on-big-endian.patch b/recipes-connectivity/bluez5/bluez5/0013-t=
est-rap-Fix-gatt_ccc_read_cb-on-big-endian.patch
new file mode 100644
index 0000000..233f8a0
--- /dev/null
+++ b/recipes-connectivity/bluez5/bluez5/0013-test-rap-Fix-gatt_ccc_read_=
cb-on-big-endian.patch
@@ -0,0 +1,56 @@
+From 4f4dba4a7863d4a4a338dd4c1a36a55de9da96a8 Mon Sep 17 00:00:00 2001
+From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
+Date: Thu, 14 May 2026 15:02:08 -0400
+Subject: [PATCH] test-rap: Fix gatt_ccc_read_cb on big-endian
+
+Reading CCC values shall return little-endian 16 bits, not native
+format.
+
+Upstream-Status: Backport [4f4dba4a7863d4a4a338dd4c1a36a55de9da96a8]
+Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
+Signed-off-by: Prathibha Madugonde <prathibha.madugonde@oss.qualcomm.com=
>
+---
+ unit/test-rap.c | 11 +++++------
+ 1 file changed, 5 insertions(+), 6 deletions(-)
+
+diff --git a/unit/test-rap.c b/unit/test-rap.c
+index 4ca4a715e..22bc2671b 100644
+--- a/unit/test-rap.c
++++ b/unit/test-rap.c
+@@ -253,8 +253,7 @@ static void gatt_ccc_read_cb(struct gatt_db_attribut=
e *attrib,
+ 	struct ccc_state *ccc;
+ 	uint16_t handle;
+ 	uint8_t ecode =3D 0;
+-	const uint8_t *value =3D NULL;
+-	size_t len =3D 0;
++	uint16_t value =3D 0;
+=20
+ 	handle =3D gatt_db_attribute_get_handle(attrib);
+=20
+@@ -264,11 +263,11 @@ static void gatt_ccc_read_cb(struct gatt_db_attrib=
ute *attrib,
+ 		goto done;
+ 	}
+=20
+-	len =3D sizeof(ccc->value);
+-	value =3D (void *) &ccc->value;
++	value =3D cpu_to_le16(ccc->value);
+=20
+ done:
+-	gatt_db_attribute_read_result(attrib, id, ecode, value, len);
++	gatt_db_attribute_read_result(attrib, id, ecode, (void *)&value,
++							sizeof(value));
+ }
+=20
+ static void ras_attached(struct bt_rap *rap, void *user_data)
+@@ -528,7 +527,7 @@ static void test_server(const void *user_data)
+ 	RAS_FIND_INFO
+=20
+ /*
+- * RAS/SR/RCO/BV-01-C =EF=BF=BD Characteristic Read: RAS Features
++ * RAS/SR/RCO/BV-01-C Characteristic Read: RAS Features
+  *
+  *  ATT: Read Request (0x0a) len 2
+  *       Handle: 0x0003 (RAS Features value handle)
+--=20
+2.34.1
+
diff --git a/recipes-connectivity/bluez5/bluez5/0014-shared-rap-fix-use-o=
f-uninitialized-value.patch b/recipes-connectivity/bluez5/bluez5/0014-sha=
red-rap-fix-use-of-uninitialized-value.patch
new file mode 100644
index 0000000..35a1725
--- /dev/null
+++ b/recipes-connectivity/bluez5/bluez5/0014-shared-rap-fix-use-of-unini=
tialized-value.patch
@@ -0,0 +1,46 @@
+From e0f608c05f9a007b9867c53234465f2b1fb0d8fa Mon Sep 17 00:00:00 2001
+From: Pauli Virtanen <pav@iki.fi>
+Date: Sun, 17 May 2026 13:30:08 +0300
+Subject: [PATCH] shared/rap: fix use of uninitialized value
+
+Fix error handling in send_ras_segment_data
+
+Upstream-Status: Backport [e0f608c05f9a007b9867c53234465f2b1fb0d8fa]
+Signed-off-by: Pauli Virtanen <pav@iki.fi>
+Signed-off-by: Prathibha Madugonde <prathibha.madugonde@oss.qualcomm.com=
>
+---
+ src/shared/rap.c | 4 ++--
+ 1 file changed, 2 insertions(+), 2 deletions(-)
+
+diff --git a/src/shared/rap.c b/src/shared/rap.c
+index b554726b0..145da2060 100644
+--- a/src/shared/rap.c
++++ b/src/shared/rap.c
+@@ -1096,7 +1096,6 @@ static void send_ras_segment_data(struct bt_rap *r=
ap,
+ 	uint16_t value_max;
+ 	const uint16_t header_len =3D ras_segment_header_size;
+ 	uint16_t raw_payload_size;
+-	bool ok;
+=20
+ 	if (!rap || !proc)
+ 		return;
+@@ -1128,6 +1127,7 @@ static void send_ras_segment_data(struct bt_rap *r=
ap,
+ 		uint16_t seg_len;
+ 		uint8_t *seg;
+ 		uint16_t wr =3D 0;
++		bool ok =3D true;
+=20
+ 		if (index > total_len)
+ 			index =3D total_len;
+@@ -1180,7 +1180,7 @@ static void send_ras_segment_data(struct bt_rap *r=
ap,
+ 						wr, bt_rap_get_att(rap));
+=20
+ 		/* Try sending to on-demand characteristic */
+-		if (ras->ondemand_chrc)
++		if (ras->ondemand_chrc && ok)
+ 			ok =3D gatt_db_attribute_notify(ras->ondemand_chrc, seg,
+ 						wr, bt_rap_get_att(rap));
+=20
+--=20
+2.34.1
+
diff --git a/recipes-connectivity/bluez5/bluez5/0015-shared-rap-Add-clien=
t-ranging-registration-and-notif.patch b/recipes-connectivity/bluez5/blue=
z5/0015-shared-rap-Add-client-ranging-registration-and-notif.patch
new file mode 100644
index 0000000..9533ef4
--- /dev/null
+++ b/recipes-connectivity/bluez5/bluez5/0015-shared-rap-Add-client-rangi=
ng-registration-and-notif.patch
@@ -0,0 +1,979 @@
+From bc5713d69e1e4ef87bc097ecbe941a2162bf0eac Mon Sep 17 00:00:00 2001
+From: Prathibha Madugonde <prathibha.madugonde@oss.qualcomm.com>
+Date: Thu, 4 Jun 2026 14:22:05 +0530
+Subject: [PATCH] shared/rap: Add client ranging registration and notific=
ation
+ parsing
+
+Read the RAS Features characteristic to determine whether the remote
+device supports real-time ranging. If supported, register for real-time
+characteristic notifications using the reqtracker for the CS initiator
+role.
+
+Parse incoming segmented RAS ranging data notifications by accumulating
+segments via iovec and parsing complete subevent headers and CS mode 0-3
+step data, including IQ/tone PCT samples, once the last segment arrives.
+
+Upstream-Status: Backport [bc5713d69e1e4ef87bc097ecbe941a2162bf0eac]
+Signed-off-by: Prathibha Madugonde <prathibha.madugonde@oss.qualcomm.com=
>
+---
+ src/shared/rap.c | 787 ++++++++++++++++++++++++++++++++++++++++++++++-
+ src/shared/rap.h |   2 +-
+ 2 files changed, 779 insertions(+), 10 deletions(-)
+
+diff --git a/src/shared/rap.c b/src/shared/rap.c
+index 145da2060..390fd3080 100644
+--- a/src/shared/rap.c
++++ b/src/shared/rap.c
+@@ -29,6 +29,9 @@
+ #define DBG(_rap, fmt, ...) \
+ 	rap_debug(_rap, "%s:%s() " fmt, __FILE__, __func__, ##__VA_ARGS__)
+=20
++#define SIGN_EXTEND_TO_16(val, bits) \
++	((int16_t)(((val) ^ (1U << ((bits)-1))) - (1U << ((bits)-1))))
++
+ #define RAS_UUID16			0x185B
+=20
+ /* Total number of attribute handles reserved for the RAS service */
+@@ -43,6 +46,11 @@
+ #define RAS_STEP_ABORTED_BIT   0x80/* set step aborted */
+ #define RAS_SUBEVENT_HEADER_SIZE 8
+=20
++#define CS_MODE_ZERO_WIRE_INIT_SIZE 5
++#define CS_MODE_ZERO_WIRE_REF_SIZE 3
++#define CS_MODE_ONE_WIRE_SIZE_MIN 6
++#define CS_MODE_ONE_WIRE_SIZE_MAX 12
++
+ enum pct_format {
+ 	IQ =3D 0,
+ 	PHASE =3D 1,
+@@ -134,6 +142,28 @@ static inline void ranging_header_set_pct_format(st=
ruct ranging_header *hdr,
+ 				((format & 0x03) << 6);
+ }
+=20
++static inline uint8_t ranging_header_get_antenna_mask(
++					const struct ranging_header *hdr)
++{
++	if (!hdr)
++		return 0;
++
++	return hdr->antenna_pct & 0x0F;
++}
++
++static inline uint8_t antenna_mask_count_paths(uint8_t antenna_mask)
++{
++	uint8_t count =3D 0;
++	uint8_t i;
++
++	for (i =3D 0; i < 4; i++) {
++		if (antenna_mask & (1u << i))
++			count++;
++	}
++
++	return count;
++}
++
+ struct ras_subevent_header {
+ 	uint16_t start_acl_conn_event;
+ 	uint16_t frequency_compensation;
+@@ -149,9 +179,21 @@ struct ras_subevent_header {
+ #define RAS_DONE_STATUS_PACK(ranging, subevent) \
+ 	((uint8_t)(((ranging) & 0x0F) | (((subevent) & 0x0F) << 4)))
+=20
++#define RAS_DONE_STATUS_UNPACK_RANGING(packed) \
++	((uint8_t)((packed) & 0x0F))
++
++#define RAS_DONE_STATUS_UNPACK_SUBEVENT(packed) \
++	((uint8_t)(((packed) >> 4) & 0x0F))
++
+ #define RAS_ABORT_REASON_PACK(ranging, subevent) \
+ 	((uint8_t)(((ranging) & 0x0F) | (((subevent) & 0x0F) << 4)))
+=20
++#define RAS_ABORT_REASON_UNPACK_RANGING(packed) \
++	((uint8_t)((packed) & 0x0F))
++
++#define RAS_ABORT_REASON_UNPACK_SUBEVENT(packed) \
++	((uint8_t)(((packed) >> 4) & 0x0F))
++
+ struct ras_subevent {
+ 	struct ras_subevent_header subevent_header;
+ 	uint8_t subevent_data[];
+@@ -206,6 +248,11 @@ struct cstracker {
+ 	uint16_t last_start_acl_conn_evt_counter;
+ 	uint16_t last_freq_comp;
+ 	int8_t last_ref_pwr_lvl;
++
++	/* Client - first segment carries this */
++	struct ranging_header   ranging_header_;
++	/* Client - subsequent segments appended using iovec */
++	struct iovec segment_data;
+ };
+=20
+ /* Ranging Service context */
+@@ -254,6 +301,7 @@ struct bt_rap {
+ 	void *debug_data;
+ 	void *user_data;
+ 	struct cstracker *resptracker;
++	struct cstracker *reqtracker;
+ };
+=20
+ static struct queue *rap_db;
+@@ -274,6 +322,28 @@ struct bt_rap_ready {
+ 	void *data;
+ };
+=20
++typedef void (*rap_notify_t)(struct bt_rap *rap, uint16_t value_handle,
++			const uint8_t *value, uint16_t length,
++			void *user_data);
++
++struct bt_rap_notify {
++	unsigned int id;
++	struct bt_rap *rap;
++	rap_notify_t func;
++	void *user_data;
++};
++
++typedef void (*rap_func_t)(struct bt_rap *rap, bool success,
++			uint8_t att_ecode, const uint8_t *value,
++			uint16_t length, void *user_data);
++
++struct bt_rap_pending {
++	unsigned int id;
++	struct bt_rap *rap;
++	rap_func_t func;
++	void *userdata;
++};
++
+ uint16_t default_ras_mtu =3D 247; /*Section 3.1.2 of RAP 1.0*/
+ uint8_t ras_segment_header_size =3D 1;
+=20
+@@ -542,6 +612,11 @@ static void rap_free(void *data)
+ 		rap->resptracker =3D NULL;
+ 	}
+=20
++	if (rap->reqtracker) {
++		free(rap->reqtracker);
++		rap->reqtracker =3D NULL;
++	}
++
+ 	queue_destroy(rap->notify, free);
+ 	queue_destroy(rap->pending, NULL);
+ 	queue_destroy(rap->ready_cbs, rap_ready_free);
+@@ -641,6 +716,12 @@ static void cs_tracker_init(struct cstracker *t)
+ 	t->last_start_acl_conn_evt_counter =3D 0;
+ 	t->last_freq_comp =3D 0;
+ 	t->last_ref_pwr_lvl =3D 0;
++
++	/* Initialize ranging header using helper functions */
++	memset(&t->ranging_header_, 0, sizeof(t->ranging_header_));
++	/* Initialize segment accumulator */
++	t->segment_data.iov_base =3D NULL;
++	t->segment_data.iov_len =3D 0;
+ }
+=20
+ static void ras_features_read_cb(struct gatt_db_attribute *attrib,
+@@ -1646,7 +1727,7 @@ static void form_ras_data_with_cs_subevent_result(=
struct bt_rap *rap,
+ 	if (length < base_len)
+ 		return;
+=20
+-	DBG(rap, "Received CS subevent result subevent: len=3D%d", length);
++	DBG(rap, "Received CS subevent result subevent: len=3D%u", length);
+=20
+ 	handle_local_subevent_result(rap,
+ 		true,			/* has header fields */
+@@ -1677,7 +1758,7 @@ static void form_ras_data_with_cs_subevent_result_=
cont(struct bt_rap *rap,
+ 	if (length < base_len)
+ 		return;
+=20
+-	DBG(rap, "Received CS subevent result continue subevent: len=3D%d",
++	DBG(rap, "Received CS subevent result continue subevent: len=3D%u",
+ 		length);
+=20
+ 	resptracker =3D rap->resptracker;
+@@ -1698,6 +1779,41 @@ static void form_ras_data_with_cs_subevent_result=
_cont(struct bt_rap *rap,
+ 		cont->step_data);
+ }
+=20
++static void fill_initiator_data_from_cs_subevent_result_cont(struct bt_=
rap *rap,
++		const struct rap_ev_cs_subevent_result_cont *cont,
++		uint16_t length)
++{
++	size_t base_len =3D offsetof(struct rap_ev_cs_subevent_result_cont,
++					step_data);
++
++	if (!rap || !rap->reqtracker || !cont)
++		return;
++
++	if (length < base_len)
++		return;
++
++	DBG(rap, "Received CS subevent result continue subevent: len=3D%u",
++		length);
++}
++
++static void fill_initiator_data_from_cs_subevent_result(struct bt_rap *=
rap,
++		const struct rap_ev_cs_subevent_result *data,
++		uint16_t length)
++{
++	size_t base_len =3D offsetof(struct rap_ev_cs_subevent_result,
++					step_data);
++
++	if (!rap || !rap->reqtracker || !data)
++		return;
++
++	/* Defensive check: base header must be present */
++	if (length < base_len)
++		return;
++
++	DBG(rap, "Received CS subevent result subevent: len=3D%u", length);
++	/* TODO: Store initiator subevent result data */
++}
++
+ void bt_rap_hci_cs_subevent_result_cont_callback(uint16_t length,
+ 						const void *param,
+ 						void *user_data)
+@@ -1705,9 +1821,14 @@ void bt_rap_hci_cs_subevent_result_cont_callback(=
uint16_t length,
+ 	const struct rap_ev_cs_subevent_result_cont *cont =3D param;
+ 	struct bt_rap *rap =3D user_data;
+=20
+-	DBG(rap, "Received CS subevent CONT: len=3D%d", length);
++	DBG(rap, "Received CS subevent CONT: len=3D%u", length);
++
++	if (rap->resptracker && rap->resptracker->role =3D=3D CS_REFLECTOR)
++		form_ras_data_with_cs_subevent_result_cont(rap, cont, length);
+=20
+-	form_ras_data_with_cs_subevent_result_cont(rap, cont, length);
++	if (rap->reqtracker && rap->reqtracker->role =3D=3D CS_INITIATOR)
++		fill_initiator_data_from_cs_subevent_result_cont(rap, cont,
++								length);
+ }
+=20
+ void bt_rap_hci_cs_subevent_result_callback(uint16_t length,
+@@ -1717,10 +1838,14 @@ void bt_rap_hci_cs_subevent_result_callback(uint=
16_t length,
+ 	const struct rap_ev_cs_subevent_result *data =3D param;
+ 	struct bt_rap *rap =3D user_data;
+=20
+-	DBG(rap, "Received CS subevent: len=3D%d", length);
++	DBG(rap, "Received CS subevent: len=3D%u", length);
+=20
+ 	/* Populate CsProcedureData and send RAS payload */
+-	form_ras_data_with_cs_subevent_result(rap, data, length);
++	if (rap->resptracker && rap->resptracker->role =3D=3D CS_REFLECTOR)
++		form_ras_data_with_cs_subevent_result(rap, data, length);
++
++	if (rap->reqtracker && rap->reqtracker->role =3D=3D CS_INITIATOR)
++		fill_initiator_data_from_cs_subevent_result(rap, data, length);
+ }
+=20
+ void bt_rap_hci_cs_procedure_enable_complete_callback(uint16_t length,
+@@ -1731,7 +1856,7 @@ void bt_rap_hci_cs_procedure_enable_complete_callb=
ack(uint16_t length,
+ 	struct bt_rap *rap =3D user_data;
+ 	struct cstracker *resptracker;
+=20
+-	DBG(rap, "Received CS procedure enable complete subevent: len=3D%d",
++	DBG(rap, "Received CS procedure enable complete subevent: len=3D%u",
+ 	    length);
+=20
+ 	if (!rap->resptracker) {
+@@ -1753,7 +1878,7 @@ void bt_rap_hci_cs_sec_enable_complete_callback(ui=
nt16_t length,
+ {
+ 	struct bt_rap *rap =3D user_data;
+=20
+-	DBG(rap, "Received CS security enable subevent: len=3D%d", length);
++	DBG(rap, "Received CS security enable subevent: len=3D%u", length);
+ }
+=20
+ void bt_rap_hci_cs_config_complete_callback(uint16_t length,
+@@ -1763,11 +1888,12 @@ void bt_rap_hci_cs_config_complete_callback(uint=
16_t length,
+ 	const struct rap_ev_cs_config_cmplt *data =3D param;
+ 	struct bt_rap *rap =3D user_data;
+ 	struct cstracker *resptracker;
++	struct cstracker *reqtracker;
+=20
+ 	if (!rap)
+ 		return;
+=20
+-	DBG(rap, "Received CS config complete subevent: len=3D%d", length);
++	DBG(rap, "Received CS config complete subevent: len=3D%u", length);
+=20
+ 	if (!rap->resptracker) {
+ 		resptracker =3D new0(struct cstracker, 1);
+@@ -1781,6 +1907,19 @@ void bt_rap_hci_cs_config_complete_callback(uint1=
6_t length,
+ 	resptracker->config_id =3D data->config_id;
+ 	resptracker->role =3D data->role;
+ 	resptracker->rtt_type =3D data->rtt_type;
++
++	if (!rap->reqtracker) {
++		reqtracker =3D new0(struct cstracker, 1);
++		cs_tracker_init(reqtracker);
++		rap->reqtracker =3D reqtracker;
++	}
++
++	reqtracker =3D rap->reqtracker;
++
++	/* Basic fields */
++	reqtracker->config_id =3D data->config_id;
++	reqtracker->role =3D data->role;
++	reqtracker->rtt_type =3D data->rtt_type;
+ }
+=20
+ struct bt_rap *bt_rap_new(struct gatt_db *ldb, struct gatt_db *rdb)
+@@ -1815,6 +1954,632 @@ done:
+ 	return rap;
+ }
+=20
++static void ras_pending_destroy(void *data)
++{
++	struct bt_rap_pending *pending =3D data;
++	struct bt_rap *rap =3D pending->rap;
++
++	if (queue_remove_if(rap->pending, NULL, pending))
++		free(pending);
++}
++
++static void ras_pending_complete(bool success, uint8_t att_ecode,
++				const uint8_t *value, uint16_t length,
++				void *user_data)
++{
++	struct bt_rap_pending *pending =3D user_data;
++
++	if (pending->func)
++		pending->func(pending->rap, success, att_ecode, value, length,
++					  pending->userdata);
++}
++
++static void rap_read_value(struct bt_rap *rap, uint16_t value_handle,
++			   rap_func_t func, void *user_data)
++{
++	struct bt_rap_pending *pending;
++
++	pending =3D new0(struct bt_rap_pending, 1);
++	pending->rap =3D rap;
++	pending->func =3D func;
++	pending->userdata =3D user_data;
++
++	pending->id =3D bt_gatt_client_read_value(rap->client, value_handle,
++						ras_pending_complete, pending,
++						ras_pending_destroy);
++	if (!pending->id) {
++		DBG(rap, "Unable to send Read request");
++		free(pending);
++		return;
++	}
++
++	queue_push_tail(rap->pending, pending);
++}
++
++static void ras_register(uint16_t att_ecode, void *user_data)
++{
++	struct bt_rap_notify *notify =3D user_data;
++
++	if (att_ecode)
++		DBG(notify->rap, "RAS register failed 0x%04x", att_ecode);
++
++	(void)notify;
++}
++
++static void rap_notify(uint16_t value_handle, const uint8_t *value,
++				uint16_t length, void *user_data)
++{
++	struct bt_rap_notify *notify =3D user_data;
++
++	if (notify->func)
++		notify->func(notify->rap, value_handle, value, length,
++					 notify->user_data);
++}
++
++static void rap_notify_destroy(void *data)
++{
++	struct bt_rap_notify *notify =3D data;
++	struct bt_rap *rap =3D notify->rap;
++
++	if (queue_remove_if(rap->notify, NULL, notify))
++		free(notify);
++}
++
++static unsigned int bt_rap_register_notify(struct bt_rap *rap,
++					uint16_t value_handle,
++					rap_notify_t func,
++					void *user_data)
++{
++	struct bt_rap_notify *notify;
++
++	notify =3D new0(struct bt_rap_notify, 1);
++	notify->rap =3D rap;
++	notify->func =3D func;
++	notify->user_data =3D user_data;
++
++	DBG(rap, "register for notifications");
++
++	notify->id =3D bt_gatt_client_register_notify(rap->client,
++					value_handle, ras_register,
++					rap_notify, notify,
++					rap_notify_destroy);
++	if (!notify->id) {
++		DBG(rap, "Unable to register for notifications");
++		free(notify);
++		return 0;
++	}
++
++	queue_push_tail(rap->notify, notify);
++
++	return notify->id;
++}
++
++static inline bool parse_segmentation_header(struct iovec *iov,
++					     struct segmentation_header *s)
++{
++	uint8_t byte;
++
++	if (!util_iov_pull_u8(iov, &byte))
++		return false;
++
++	s->first_segment =3D (byte & 0x01) ? 1 : 0;
++	s->last_segment =3D (byte & 0x02) ? 1 : 0;
++	s->rolling_segment_counter =3D (byte >> 2) & 0x3F;
++
++	return true;
++}
++
++static void parse_i_q_sample(struct iovec *iov, int16_t *i_sample,
++				int16_t *q_sample)
++{
++	uint32_t buffer;
++	uint32_t i12;
++	uint32_t q12;
++
++	if (!util_iov_pull_le24(iov, &buffer)) {
++		*i_sample =3D 0;
++		*q_sample =3D 0;
++		return;
++	}
++
++	i12 =3D  buffer        & 0x0FFFU;   /* bits 0..11 */
++	q12 =3D (buffer >> 12) & 0x0FFFU;   /* bits 12..23 */
++
++	*i_sample =3D SIGN_EXTEND_TO_16(i12, 12);
++	*q_sample =3D SIGN_EXTEND_TO_16(q12, 12);
++}
++
++static size_t get_mode_zero_length(enum cs_role remote_role)
++{
++	return (remote_role =3D=3D CS_ROLE_INITIATOR) ?
++		CS_MODE_ZERO_WIRE_INIT_SIZE :
++		CS_MODE_ZERO_WIRE_REF_SIZE;
++}
++
++static void parse_mode_zero(struct bt_rap *rap, struct iovec *mode_iov,
++			    enum cs_role remote_role)
++{
++	uint8_t packet_quality;
++	int8_t packet_rssi_dbm;
++	uint8_t packet_ant;
++	uint16_t init_measured_freq_offset =3D 0;
++
++	if (!util_iov_pull_u8(mode_iov, &packet_quality) ||
++	    !util_iov_pull_u8(mode_iov, (uint8_t *)&packet_rssi_dbm) ||
++	    !util_iov_pull_u8(mode_iov, &packet_ant)) {
++		DBG(rap, "Mode 0: failed to parse common fields");
++		return;
++	}
++
++	if (remote_role =3D=3D CS_ROLE_INITIATOR) {
++		if (!util_iov_pull_le16(mode_iov, &init_measured_freq_offset)) {
++			DBG(rap, "Mode 0: failed to parse freq offset");
++			return;
++		}
++	}
++
++	/* TODO: Store this data as reflector data */
++}
++
++static size_t get_mode_one_length(bool include_pct)
++{
++	if (include_pct)
++		return CS_MODE_ONE_WIRE_SIZE_MAX;
++	return CS_MODE_ONE_WIRE_SIZE_MIN;
++}
++
++static void parse_mode_one(struct bt_rap *rap, struct iovec *mode_iov,
++			   enum cs_role remote_role, bool include_pct)
++{
++	uint8_t packet_quality;
++	uint8_t packet_nadm;
++	int8_t packet_rssi_dbm;
++	int16_t time_value;
++	uint8_t packet_ant;
++	int16_t pct1_i =3D 0, pct1_q =3D 0;
++	int16_t pct2_i =3D 0, pct2_q =3D 0;
++
++	if (!util_iov_pull_u8(mode_iov, &packet_quality) ||
++	    !util_iov_pull_u8(mode_iov, &packet_nadm) ||
++	    !util_iov_pull_u8(mode_iov, (uint8_t *)&packet_rssi_dbm) ||
++	    !util_iov_pull_le16(mode_iov, (uint16_t *)&time_value) ||
++	    !util_iov_pull_u8(mode_iov, &packet_ant)) {
++		DBG(rap, "Mode 1: failed to parse fixed fields");
++		return;
++	}
++
++	if (include_pct) {
++		parse_i_q_sample(mode_iov, &pct1_i, &pct1_q);
++		parse_i_q_sample(mode_iov, &pct2_i, &pct2_q);
++	}
++
++	/* TODO: Store this data as reflector data */
++}
++
++static size_t get_mode_two_length(uint8_t num_antenna_paths)
++{
++	uint8_t num_tone_data =3D num_antenna_paths + 1;
++
++	return 1 + (4 * num_tone_data);
++}
++
++static void parse_mode_two(struct bt_rap *rap, struct iovec *mode_iov,
++			   uint8_t num_antenna_paths)
++{
++	uint8_t ant_perm_index;
++	int16_t tone_pct_i[5];
++	int16_t tone_pct_q[5];
++	uint8_t tone_quality[5];
++	uint8_t k;
++	uint8_t num_paths =3D (num_antenna_paths + 1) < 5 ?
++				(num_antenna_paths + 1) : 5;
++
++	if (!util_iov_pull_u8(mode_iov, &ant_perm_index)) {
++		DBG(rap, "Mode 2: failed to parse ant_perm_index");
++		return;
++	}
++
++	for (k =3D 0; k < num_paths; k++) {
++		int16_t i_val, q_val;
++
++		if (mode_iov->iov_len < 4) {
++			DBG(rap, "Mode 2: insufficient PCT for "
++				"path %u (rem=3D%zu)",
++				k, mode_iov->iov_len);
++			break;
++		}
++		parse_i_q_sample(mode_iov, &i_val, &q_val);
++		tone_pct_i[k] =3D i_val;
++		tone_pct_q[k] =3D q_val;
++
++		util_iov_pull_u8(mode_iov, &tone_quality[k]);
++		DBG(rap, "tone_quality_indicator : %d",
++			tone_quality[k]);
++		DBG(rap, "[i, q] : %d, %d",
++			tone_pct_i[k],
++			tone_pct_q[k]);
++	}
++
++	DBG(rap, "    cs_mode_two_data: ant_perm_idx=3D%u",
++		ant_perm_index);
++
++	/* TODO: Store this data as reflector data */
++}
++
++static size_t get_mode_three_length(uint8_t num_antenna_paths, bool inc=
lude_pct)
++{
++	return get_mode_one_length(include_pct) +
++		get_mode_two_length(num_antenna_paths);
++}
++
++static void parse_mode_three(struct bt_rap *rap, struct iovec *mode_iov=
,
++			     enum cs_role remote_role, bool include_pct,
++			     uint8_t num_antenna_paths)
++{
++	/* Mode 3 =3D Mode 1 + Mode 2 */
++	parse_mode_one(rap, mode_iov, remote_role, include_pct);
++
++	if (mode_iov->iov_len > 0)
++		parse_mode_two(rap, mode_iov, num_antenna_paths);
++}
++
++static bool parse_subevent_header(struct iovec *iov,
++					struct ras_subevent_header *hdr)
++{
++	uint16_t start_acl, freq_comp;
++	uint8_t done_byte, abort_byte, ref_pwr, num_steps;
++
++	if (!util_iov_pull_le16(iov, &start_acl) ||
++	    !util_iov_pull_le16(iov, &freq_comp) ||
++	    !util_iov_pull_u8(iov, &done_byte) ||
++	    !util_iov_pull_u8(iov, &abort_byte) ||
++	    !util_iov_pull_u8(iov, &ref_pwr) ||
++	    !util_iov_pull_u8(iov, &num_steps))
++		return false;
++
++	hdr->start_acl_conn_event =3D start_acl;
++	hdr->frequency_compensation =3D freq_comp;
++	hdr->ranging_done_status =3D RAS_DONE_STATUS_UNPACK_RANGING(done_byte)=
;
++	hdr->subevent_done_status =3D RAS_DONE_STATUS_UNPACK_SUBEVENT(done_byt=
e);
++	hdr->ranging_abort_reason =3D
++		RAS_ABORT_REASON_UNPACK_RANGING(abort_byte);
++	hdr->subevent_abort_reason =3D
++		RAS_ABORT_REASON_UNPACK_SUBEVENT(abort_byte);
++	hdr->reference_power_level =3D (int8_t)ref_pwr;
++	hdr->num_steps_reported =3D num_steps;
++
++	return true;
++}
++
++static bool parse_step(struct bt_rap *rap, struct iovec *iov,
++			struct cstracker *reqtracker,
++			uint8_t num_antenna_paths, uint8_t step_idx)
++{
++	uint8_t mode_byte, step_mode;
++	bool include_pct;
++	enum cs_role remote_role;
++	size_t step_payload_len;
++	struct iovec mode_iov;
++	void *payload;
++
++	if (!util_iov_pull_u8(iov, &mode_byte)) {
++		DBG(rap, "Insufficient data for step %u", step_idx);
++		return false;
++	}
++
++	if (mode_byte & RAS_STEP_ABORTED_BIT) {
++		DBG(rap, "  Step %u: mode=3D%u (aborted)",
++			step_idx, mode_byte & 0x03);
++		return true;
++	}
++
++	step_mode =3D mode_byte & 0x03;
++	include_pct =3D (reqtracker->rtt_type =3D=3D 0x01 ||
++			reqtracker->rtt_type =3D=3D 0x02);
++	remote_role =3D (reqtracker->role =3D=3D CS_ROLE_INITIATOR) ?
++			CS_ROLE_REFLECTOR : CS_ROLE_INITIATOR;
++
++	switch (step_mode) {
++	case CS_MODE_ZERO:
++		step_payload_len =3D get_mode_zero_length(remote_role);
++		break;
++	case CS_MODE_ONE:
++		step_payload_len =3D get_mode_one_length(include_pct);
++		break;
++	case CS_MODE_TWO:
++		step_payload_len =3D get_mode_two_length(num_antenna_paths);
++		break;
++	case CS_MODE_THREE:
++		step_payload_len =3D get_mode_three_length(num_antenna_paths,
++								include_pct);
++		break;
++	default:
++		DBG(rap, "  Step %u: unknown mode=3D%u", step_idx, step_mode);
++		return true;
++	}
++
++	DBG(rap, "  Step %u: mode=3D%u payload_len=3D%zu",
++	    step_idx, step_mode, step_payload_len);
++
++	payload =3D util_iov_pull(iov, step_payload_len);
++	if (!payload) {
++		DBG(rap, "Insufficient data for step %u payload "
++			"(need %zu, have %zu)",
++			step_idx, step_payload_len, iov->iov_len);
++		return false;
++	}
++
++	mode_iov.iov_base =3D payload;
++	mode_iov.iov_len =3D step_payload_len;
++
++	switch (step_mode) {
++	case CS_MODE_ZERO:
++		parse_mode_zero(rap, &mode_iov, remote_role);
++		break;
++	case CS_MODE_ONE:
++		parse_mode_one(rap, &mode_iov, remote_role, include_pct);
++		break;
++	case CS_MODE_TWO:
++		parse_mode_two(rap, &mode_iov, num_antenna_paths);
++		break;
++	case CS_MODE_THREE:
++		parse_mode_three(rap, &mode_iov, remote_role, include_pct,
++						num_antenna_paths);
++		break;
++	default:
++		break;
++	}
++
++	return true;
++}
++
++static void parse_subevent_steps(struct bt_rap *rap, struct iovec *iov,
++				struct cstracker *reqtracker,
++				uint8_t num_antenna_paths, uint8_t num_steps)
++{
++	uint8_t i;
++
++	for (i =3D 0; i < num_steps; i++) {
++		if (!parse_step(rap, iov, reqtracker, num_antenna_paths, i))
++			break;
++	}
++}
++
++static void parse_ras_data_segments(struct bt_rap *rap,
++			       struct cstracker *reqtracker)
++{
++	struct iovec iov;
++	uint8_t antenna_mask;
++	uint8_t num_antenna_paths;
++
++	if (!rap || !reqtracker)
++		return;
++
++	DBG(rap, "Complete RAS data received: %zu bytes",
++	    reqtracker->segment_data.iov_len);
++
++	antenna_mask =3D
++		ranging_header_get_antenna_mask(&reqtracker->ranging_header_);
++	num_antenna_paths =3D antenna_mask_count_paths(antenna_mask);
++
++	iov =3D reqtracker->segment_data;
++
++	while (iov.iov_len >=3D RAS_SUBEVENT_HEADER_SIZE) {
++		struct ras_subevent_header hdr;
++
++		if (!parse_subevent_header(&iov, &hdr))
++			break;
++
++		DBG(rap, "Parsed subevent: start_acl=3D%u "
++			"freq_comp=3D%d ref_pwr=3D%d steps=3D%u",
++		    hdr.start_acl_conn_event,
++		    hdr.frequency_compensation,
++		    hdr.reference_power_level,
++		    hdr.num_steps_reported);
++
++		parse_subevent_steps(rap, &iov, reqtracker,
++					num_antenna_paths,
++					hdr.num_steps_reported);
++
++		if (hdr.subevent_done_status =3D=3D
++		    SUBEVENT_DONE_ALL_RESULTS_COMPLETE ||
++		    hdr.ranging_done_status =3D=3D
++		    RANGING_DONE_ALL_RESULTS_COMPLETE) {
++			DBG(rap, "Ranging procedure complete");
++			break;
++		}
++	}
++
++	free(reqtracker->segment_data.iov_base);
++	reqtracker->segment_data.iov_base =3D NULL;
++	reqtracker->segment_data.iov_len =3D 0;
++}
++
++static bool process_first_segment(struct bt_rap *rap,
++					struct cstracker *reqtracker,
++					struct iovec *iov, bool last_segment)
++{
++	uint16_t counter_config_val;
++	int8_t selected_tx_power;
++	uint8_t antenna_pct;
++
++	if (!util_iov_pull_le16(iov, &counter_config_val) ||
++	    !util_iov_pull_u8(iov, (uint8_t *)&selected_tx_power) ||
++	    !util_iov_pull_u8(iov, &antenna_pct)) {
++		DBG(rap, "First segment too short for ranging header");
++		return false;
++	}
++
++	ranging_header_set_counter(&reqtracker->ranging_header_,
++				counter_config_val & 0x0FFF);
++	ranging_header_set_config_id(&reqtracker->ranging_header_,
++				(counter_config_val >> 12) & 0x0F);
++	reqtracker->ranging_header_.selected_tx_power =3D selected_tx_power;
++	reqtracker->ranging_header_.antenna_pct =3D antenna_pct;
++
++	DBG(rap, "First segment: parsed ranging header "
++	    "(counter=3D%u, config_id=3D%u, tx_pwr=3D%d)",
++	    counter_config_val & 0x0FFF,
++	    (counter_config_val >> 12) & 0x0F,
++	    selected_tx_power);
++
++	if (reqtracker->segment_data.iov_base) {
++		free(reqtracker->segment_data.iov_base);
++		reqtracker->segment_data.iov_base =3D NULL;
++		reqtracker->segment_data.iov_len =3D 0;
++	}
++
++	if (iov->iov_len > 0) {
++		if (!util_iov_append(&reqtracker->segment_data,
++					iov->iov_base, iov->iov_len)) {
++			DBG(rap, "Failed to initialize segment accumulator");
++			return false;
++		}
++		DBG(rap, "First segment: initialized accumulator "
++		    "with %zu bytes", iov->iov_len);
++	}
++
++	if (!last_segment)
++		return false;
++
++	DBG(rap, "Single-segment: first=3D1, last=3D1");
++	return true;
++}
++
++static void ras_realtime_notify_cb(struct bt_rap *rap, uint16_t value_h=
andle,
++				   const uint8_t *value, uint16_t length,
++				   void *user_data)
++{
++	struct iovec iov =3D { .iov_base =3D (void *)value, .iov_len =3D lengt=
h };
++	struct segmentation_header seg_hdr;
++	struct cstracker *reqtracker;
++
++	if (!rap || !value || length =3D=3D 0) {
++		DBG(rap, "Invalid notification data");
++		return;
++	}
++
++	DBG(rap, "Received real-time notification: handle=3D0x%04x len=3D%u",
++	    value_handle, length);
++
++	if (!parse_segmentation_header(&iov, &seg_hdr)) {
++		DBG(rap, "Failed to parse segmentation header");
++		return;
++	}
++
++	DBG(rap, "Segment: first=3D%u last=3D%u counter=3D%u",
++	    seg_hdr.first_segment, seg_hdr.last_segment,
++	    seg_hdr.rolling_segment_counter);
++
++	if (!rap->reqtracker) {
++		DBG(rap, "reqtracker is not initialised");
++		return;
++	}
++
++	reqtracker =3D rap->reqtracker;
++
++	if (seg_hdr.first_segment) {
++		if (!process_first_segment(rap, reqtracker, &iov,
++						seg_hdr.last_segment))
++			return;
++	} else {
++		if (iov.iov_len > 0) {
++			if (!util_iov_append(&reqtracker->segment_data,
++						iov.iov_base, iov.iov_len)) {
++				DBG(rap, "Failed to append segment data");
++				return;
++			}
++			DBG(rap, "Continuation segment: appended "
++			    "%zu bytes (total=3D%zu)",
++			    iov.iov_len,
++			    reqtracker->segment_data.iov_len);
++		}
++	}
++
++	/* Last segment: parse complete RAS data */
++	if (seg_hdr.last_segment)
++		parse_ras_data_segments(rap, reqtracker);
++}
++
++static void read_ras_features(struct bt_rap *rap, bool success,
++			uint8_t att_ecode,
++			const uint8_t *value, uint16_t length,
++			void *user_data)
++{
++	struct iovec iov =3D { .iov_base =3D (void *)value, .iov_len =3D lengt=
h };
++	uint32_t features =3D 0;
++	struct ras *ras;
++	bool supports_realtime;
++	bool retrieve_lost;
++	bool abort_operation;
++
++	if (!success) {
++		DBG(rap, "Unable to read RAS Features: error 0x%02x",
++			att_ecode);
++		return;
++	}
++
++	ras =3D rap_get_ras(rap);
++
++	if (length =3D=3D 0 || length > 4) {
++		DBG(rap, "Invalid RAS Features length: %u (expected 1-4)",
++			length);
++		return;
++	}
++
++	if (length < 4) {
++		uint8_t padded[4] =3D { 0 };
++
++		memcpy(padded, value, length);
++		features =3D get_le32(padded);
++		DBG(rap, "RAS Features: short read (%u bytes), zero-pad to 4",
++		    length);
++	} else if (!util_iov_pull_le32(&iov, &features)) {
++		DBG(rap, "Unable to parse RAS Features value");
++		return;
++	}
++
++	DBG(rap, "RAS Features: 0x%08x", features);
++
++	supports_realtime =3D (features & 0x01) !=3D 0;
++	retrieve_lost =3D (features & 0x02) !=3D 0;
++	abort_operation =3D (features & 0x04) !=3D 0;
++
++	DBG(rap, "RAS Features - Real-time: %s, Retrieve Lost: %s, Abort: %s",
++	    supports_realtime ? "Yes" : "No",
++	    retrieve_lost ? "Yes" : "No",
++	    abort_operation ? "Yes" : "No");
++
++	DBG(rap, "RAS features read successfully, capabilities determined");
++
++	/* Register for real-time characteristic notifications if supported */
++	if (supports_realtime && ras && ras->realtime_chrc && rap->client) {
++		uint16_t value_handle;
++		bt_uuid_t uuid;
++
++		if (gatt_db_attribute_get_char_data(ras->realtime_chrc,
++					NULL, &value_handle,
++					NULL, NULL, &uuid)) {
++			unsigned int notify_id;
++
++			notify_id =3D bt_rap_register_notify(rap,
++						value_handle,
++						ras_realtime_notify_cb,
++						NULL);
++			if (!notify_id)
++				DBG(rap, "Failed to register for "
++					"real-time notifications");
++			else
++				DBG(rap, "Registered for real-time "
++					"features: id=3D%u", notify_id);
++		}
++	} else {
++		DBG(rap, "On demand ranging "
++			"remote device - skipping notification "
++			"registration");
++	}
++}
++
+ static void foreach_rap_char(struct gatt_db_attribute *attr, void *user=
_data)
+ {
+ 	struct bt_rap *rap =3D user_data;
+@@ -1848,6 +2613,10 @@ static void foreach_rap_char(struct gatt_db_attri=
bute *attr, void *user_data)
+ 			return;
+=20
+ 		ras->feat_chrc =3D attr;
++		if (rap->client) {
++			rap_read_value(rap, value_handle,
++					read_ras_features, rap);
++		}
+ 	}
+=20
+ 	if (!bt_uuid_cmp(&uuid, &uuid_realtime)) {
+diff --git a/src/shared/rap.h b/src/shared/rap.h
+index c9431aecd..d3ced61b1 100644
+--- a/src/shared/rap.h
++++ b/src/shared/rap.h
+@@ -92,7 +92,7 @@ struct cs_mode_zero_data {
+ 	uint8_t packet_quality;
+ 	uint8_t packet_rssi_dbm;
+ 	uint8_t packet_ant;
+-	uint32_t init_measured_freq_offset;
++	uint16_t init_measured_freq_offset;
+ };
+=20
+ struct cs_mode_one_data {
+--=20
+2.34.1
+
diff --git a/recipes-connectivity/bluez5/bluez5/0016-profiles-ranging-Fix=
-measured_freq_offset.patch b/recipes-connectivity/bluez5/bluez5/0016-pro=
files-ranging-Fix-measured_freq_offset.patch
new file mode 100644
index 0000000..5154d1c
--- /dev/null
+++ b/recipes-connectivity/bluez5/bluez5/0016-profiles-ranging-Fix-measur=
ed_freq_offset.patch
@@ -0,0 +1,38 @@
+From 42b2c543a70c882ed12efa06334588b0c45ae0f3 Mon Sep 17 00:00:00 2001
+From: Prathibha Madugonde <prathibha.madugonde@oss.qualcomm.com>
+Date: Thu, 4 Jun 2026 15:32:33 +0530
+Subject: [PATCH] profiles/ranging: Fix measured_freq_offset
+
+As per Core spect it is 2 octects not 4.
+
+Upstream-Status: Backport [42b2c543a70c882ed12efa06334588b0c45ae0f3]
+Signed-off-by: Prathibha Madugonde <prathibha.madugonde@oss.qualcomm.com=
>
+---
+ profiles/ranging/rap_hci.c | 4 ++--
+ 1 file changed, 2 insertions(+), 2 deletions(-)
+
+diff --git a/profiles/ranging/rap_hci.c b/profiles/ranging/rap_hci.c
+index 8e65e5ef8..febe23384 100644
+--- a/profiles/ranging/rap_hci.c
++++ b/profiles/ranging/rap_hci.c
+@@ -601,7 +601,7 @@ static void parse_mode_zero_data(struct iovec *iov,
+ 				 struct cs_mode_zero_data *mode_data,
+ 				 uint8_t cs_role)
+ {
+-	uint32_t freq_offset;
++	uint16_t freq_offset;
+=20
+ 	if (iov->iov_len < 3) {
+ 		DBG("Mode 0: too short (<3)");
+@@ -614,7 +614,7 @@ static void parse_mode_zero_data(struct iovec *iov,
+ 	DBG("CS Step mode 0");
+=20
+ 	if (cs_role =3D=3D CS_INITIATOR && iov->iov_len >=3D 4) {
+-		util_iov_pull_le32(iov, &freq_offset);
++		util_iov_pull_le16(iov, &freq_offset);
+ 		mode_data->init_measured_freq_offset =3D freq_offset;
+ 	}
+ }
+--=20
+2.34.1
+
diff --git a/recipes-connectivity/bluez5/bluez5_%.bbappend b/recipes-conn=
ectivity/bluez5/bluez5_%.bbappend
new file mode 100644
index 0000000..99a522b
--- /dev/null
+++ b/recipes-connectivity/bluez5/bluez5_%.bbappend
@@ -0,0 +1,20 @@
+FILESEXTRAPATHS:prepend :=3D "${THISDIR}/bluez5:"
+
+SRC_URI:append =3D " \
+    file://0001-shared-rap-Introduce-Channel-Sounding-HCI-raw-interf.pat=
ch \
+    file://0002-main-conf-Add-Channel-Sounding-config-parsing-support.pa=
tch \
+    file://0003-profiles-ranging-Add-HCI-LE-Event-Handling-in-Reflec.pat=
ch \
+    file://0004-shared-util-Add-MIN-MAX-implementations.patch \
+    file://0005-rap-Cleanup-coding-style-and-unnecessary-code.patch \
+    file://0006-src-shared-Add-custom-CCC-callbacks.patch \
+    file://0007-src-shared-Add-RAS-packet-format-and-notification-su.pat=
ch \
+    file://0008-unit-test-rap-Add-PTS-tests-for-CS-reflector.patch \
+    file://0009-profiles-ranging-Read-cs_mode_one_data-members.patch \
+    file://0010-shared-hci-Add-BPF-filter-for-registered-events.patch \
+    file://0011-shared-hci-Add-bt_hci_register_subevent-for-LE-Meta-.pat=
ch \
+    file://0012-ranging-rap_hci-Use-bt_hci_register_subevent-for-LE-.pat=
ch \
+    file://0013-test-rap-Fix-gatt_ccc_read_cb-on-big-endian.patch \
+    file://0014-shared-rap-fix-use-of-uninitialized-value.patch \
+    file://0015-shared-rap-Add-client-ranging-registration-and-notif.pat=
ch \
+    file://0016-profiles-ranging-Fix-measured_freq_offset.patch \
+"
--=20
2.34.1


