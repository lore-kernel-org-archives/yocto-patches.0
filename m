Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9022CCD183
	for <webhook@archiver.kernel.org>; Thu, 16 Oct 2025 21:22:44 +0000 (UTC)
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
 by mx.groups.io with SMTP id smtpd.web11.1676.1760649761510990012
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 16 Oct 2025 14:22:41 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=POjaeevd;
 spf=pass (domain: konsulko.com, ip: 209.85.219.49, mailfrom: scott.murray@konsulko.com)
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-78f75b0a058so16625696d6.0
        for <yocto-patches@lists.yoctoproject.org>; Thu, 16 Oct 2025 14:22:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1760649760; x=1761254560; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QfnFWY5mytOtQh0enEd2amuv0usp/0rrnUqIaYh7IM8=;
        b=POjaeevdeJv87TrThcHxTe0S7uK7MpGSVfTgwwHPmi9U69oxJEEtoXeQuf4Hu/MOj1
         k/xrU5Oa52EsWyKwR+UVCydE2D9ihy4cFo5NcyDzArnX9ScyngL88XEu/pIppPg3Htw7
         eNS+meS3UeZQFwMyCsRLMFHfq9xQVwe68903E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760649760; x=1761254560;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QfnFWY5mytOtQh0enEd2amuv0usp/0rrnUqIaYh7IM8=;
        b=xGzvkhLl8qN09jn7ThR5Q6a8PZV1ptOcu0NfV6qM9AJ6o6H+5dPwIDmq2INNRsJVYM
         5GEHt2L3CP5ntRuTIXFCYYJ6OCEj+8EGBKyn4WOxoaMqZ+Oh6yY666btoOBfsJ/RyGwN
         /u4oSI+zpCtO8JEYLDNUARfkPF95IEeKD4gArusJSO7Kbmp2mm22NGvY354P19RjQvkK
         dbvz9I01T+pHCREst0g+2pcwDrXxryagkm2r9eOWnrl8at1XbS7bPZH6tgOURfqDgZuj
         BwegZnC6k4f1xDHH9cEzqaeVhqaW+636f4Ncv7dxfx5Cc6+UEU7gNRL8UEkDAhstKtRD
         2FeQ==
X-Gm-Message-State: AOJu0YxW93NhRVh0Ri2N+yiUf1Li8DEY+2UjOs4gsfwvr0Adm7EdXAES
	6F6kRSPvQ4WGPCtUjVRDmbqKRMTzyQwEGfksvWSaCYB882Q94l3DV30WVl3Yf4GNMpElMVdTiT5
	Ts3e9
X-Gm-Gg: ASbGncsH14a2OrvJGt/JPavwY/4T3mfDKcd0ULvcsllbgIgMTyOqi65ScvNk0LrNSsV
	CgU6aPdzMNqh3V0ZDcFTxS9RKas7+tTFs7dPWdF2Ud+iF+WdCx6J5W37KgueSjyyrVItvnn1i/r
	frbDjovaogfFxiKFi9b+jsmfT9AAubpYUASbMlQr0i4aJh5InL8lU1v5l+5/PRTy3Rp/8kFjsum
	6w6fTnMbw2WfMhsH2KkoRqX1r1U8hanNWyS2lIinG8sqTKX8sVnOcN8mjnp2ZMSIF7AinOGFcaM
	Y7zytnrSBXvM04sYTTz8/ESsw+QxUPYZEAe5SqYBupzdSZG8iib0HX/p7kGp1/b+/NRLfE0kKYw
	65hJ1U8ItkZt4MZjYOb0p4V1b7iaR4ntn0+1KJSg5DW3bH68dmDSCODgtXcuMOSRc+zzJgHf+Oy
	Fuzut0hLNP1fIq5aOjv0x8jgKQWIPwFnlb3o0iKTDw/4vK3ISWwY29Us4eJcJlv7I=
X-Google-Smtp-Source: AGHT+IGCJBLRxiGTXb+O4jY0KBfZTDrtopf06P/9VyMpMBNH6r66sUExeFVpvP8qFEhL+xycCyTs7g==
X-Received: by 2002:a05:6214:409:b0:815:2c80:553c with SMTP id 6a1803df08f44-87c2058995dmr22944226d6.26.1760649760140;
        Thu, 16 Oct 2025 14:22:40 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-87c1c2fd4f4sm14647466d6.7.2025.10.16.14.22.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 14:22:39 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Marta Rybczynska <marta.rybczynska@ygreky.com>
Subject: [meta-security][PATCH 09/15] suricata-update: add package to pull files
Date: Thu, 16 Oct 2025 17:22:08 -0400
Message-ID: <cb8c6f109d3aaa57fdb1c638032adab097ab2900.1760648348.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1760648348.git.scott.murray@konsulko.com>
References: <cover.1760648348.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 16 Oct 2025 21:22:44 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2334

From: Clayton Casciato <majortomtosourcecontrol@gmail.com>

suricata has "--disable-suricata-update"

Original add: caaeb67863a6 ("suricata-update: add package to pull rules")
Suricata dropped: 7a1691c03726 ("suricata: Drop 4.1.x its EOL")
Not readded: 818a8646a689 ("suricata: rust is in core")

*Changes*
1.2.1 -> 1.3.6
Drop period and trailing space in SUMMARY value
Drop now-redundant "S"
Use HTTPS protocol for SRC_URI
LICENSE "GPLv2" -> "GPL-2.0-only"
Add "python3-shell" RDEPENDS to resolve:
  ModuleNotFoundError: No module named 'shlex'

Basic target testing:
root@beaglebone-yocto:~# suricata-update
22/9/2025 -- 04:06:23 - <Info> -- Using data-directory /var/lib/suricata.
22/9/2025 -- 04:06:23 - <Info> -- Using Suricata configuration /etc/suricata/suricata.yaml
22/9/2025 -- 04:06:23 - <Info> -- Using /usr/share/suricata/rules for Suricata provided rules.
22/9/2025 -- 04:06:23 - <Info> -- Found Suricata version 7.0.0 at /bin/suricata.
22/9/2025 -- 04:06:23 - <Info> -- Loading /etc/suricata/suricata.yaml
22/9/2025 -- 04:06:23 - <Info> -- Disabling rules for protocol pgsql
22/9/2025 -- 04:06:23 - <Info> -- Disabling rules for protocol modbus
22/9/2025 -- 04:06:23 - <Info> -- Disabling rules for protocol dnp3
22/9/2025 -- 04:06:23 - <Info> -- Disabling rules for protocol enip
22/9/2025 -- 04:06:23 - <Info> -- No sources configured, will use Emerging Threats Open
22/9/2025 -- 04:06:23 - <Info> -- Fetching https://rules.emergingthreats.net/open/suricata-7.0.0/emerging.rules.tar.gz.
 100% - 5102134/5102134
22/9/2025 -- 04:06:24 - <Info> -- Done.
22/9/2025 -- 04:06:25 - <Info> -- Loading distribution rule file /usr/share/suricata/rules/app-layer-events.rules
22/9/2025 -- 04:06:25 - <Info> -- Loading distribution rule file /usr/share/suricata/rules/decoder-events.rules
22/9/2025 -- 04:06:25 - <Info> -- Loading distribution rule file /usr/share/suricata/rules/dhcp-events.rules
22/9/2025 -- 04:06:25 - <Info> -- Loading distribution rule file /usr/share/suricata/rules/dnp3-events.rules
22/9/2025 -- 04:06:25 - <Info> -- Loading distribution rule file /usr/share/suricata/rules/dns-events.rules
22/9/2025 -- 04:06:25 - <Info> -- Loading distribution rule file /usr/share/suricata/rules/files.rules
22/9/2025 -- 04:06:25 - <Info> -- Loading distribution rule file /usr/share/suricata/rules/http2-events.rules
22/9/2025 -- 04:06:25 - <Info> -- Loading distribution rule file /usr/share/suricata/rules/http-events.rules
22/9/2025 -- 04:06:25 - <Info> -- Loading distribution rule file /usr/share/suricata/rules/ipsec-events.rules
22/9/2025 -- 04:06:25 - <Info> -- Loading distribution rule file /usr/share/suricata/rules/kerberos-events.rules
22/9/2025 -- 04:06:25 - <Info> -- Loading distribution rule file /usr/share/suricata/rules/modbus-events.rules
22/9/2025 -- 04:06:25 - <Info> -- Loading distribution rule file /usr/share/suricata/rules/mqtt-events.rules
22/9/2025 -- 04:06:25 - <Info> -- Loading distribution rule file /usr/share/suricata/rules/nfs-events.rules
22/9/2025 -- 04:06:25 - <Info> -- Loading distribution rule file /usr/share/suricata/rules/ntp-events.rules
22/9/2025 -- 04:06:25 - <Info> -- Loading distribution rule file /usr/share/suricata/rules/quic-events.rules
22/9/2025 -- 04:06:25 - <Info> -- Loading distribution rule file /usr/share/suricata/rules/rfb-events.rules
22/9/2025 -- 04:06:25 - <Info> -- Loading distribution rule file /usr/share/suricata/rules/smb-events.rules
22/9/2025 -- 04:06:25 - <Info> -- Loading distribution rule file /usr/share/suricata/rules/smtp-events.rules
22/9/2025 -- 04:06:25 - <Info> -- Loading distribution rule file /usr/share/suricata/rules/ssh-events.rules
22/9/2025 -- 04:06:25 - <Info> -- Loading distribution rule file /usr/share/suricata/rules/stream-events.rules
22/9/2025 -- 04:06:25 - <Info> -- Loading distribution rule file /usr/share/suricata/rules/tls-events.rules
22/9/2025 -- 04:06:27 - <Info> -- Ignoring file ba1345f233851ca2df4d905ea4b386d2/rules/emerging-deleted.rules
22/9/2025 -- 04:06:57 - <Info> -- Loaded 61205 rules.
22/9/2025 -- 04:07:02 - <Info> -- Disabled 14 rules.
22/9/2025 -- 04:07:02 - <Info> -- Enabled 0 rules.
22/9/2025 -- 04:07:02 - <Info> -- Modified 0 rules.
22/9/2025 -- 04:07:02 - <Info> -- Dropped 0 rules.
22/9/2025 -- 04:07:03 - <Info> -- Enabled 136 rules for flowbit dependencies.
22/9/2025 -- 04:07:03 - <Info> -- Creating directory /var/lib/suricata/rules.
22/9/2025 -- 04:07:03 - <Info> -- Backing up current rules.
22/9/2025 -- 04:07:03 - <Info> -- Writing rules to /var/lib/suricata/rules/suricata.rules: total: 61205; enabled: 45406; added: 61205; removed 0; modified: 0
22/9/2025 -- 04:07:06 - <Info> -- Writing /var/lib/suricata/rules/classification.config
22/9/2025 -- 04:07:07 - <Info> -- Testing with suricata -T.
22/9/2025 -- 04:07:57 - <Info> -- Done.

Signed-off-by: Clayton Casciato <majortomtosourcecontrol@gmail.com>
---
 .../suricata/python3-suricata-update_1.3.6.bb     | 15 +++++++++++++++
 1 file changed, 15 insertions(+)
 create mode 100644 recipes-ids/suricata/python3-suricata-update_1.3.6.bb

diff --git a/recipes-ids/suricata/python3-suricata-update_1.3.6.bb b/recipes-ids/suricata/python3-suricata-update_1.3.6.bb
new file mode 100644
index 0000000..cdf2faa
--- /dev/null
+++ b/recipes-ids/suricata/python3-suricata-update_1.3.6.bb
@@ -0,0 +1,15 @@
+SUMMARY = "The tool for updating your Suricata rules"
+HOMEPAGE = "http://suricata-ids.org/"
+SECTION = "security Monitor/Admin"
+LICENSE = "GPL-2.0-only"
+
+LIC_FILES_CHKSUM = "file://LICENSE;beginline=1;endline=2;md5=c70d8d3310941dcdfcd1e02800a1f548"
+
+SRCREV = "f76a61bdee69961537585a1036c4294da28495a5"
+SRC_URI = "git://github.com/OISF/suricata-update;protocol=https;branch=master"
+
+inherit python3native python3targetconfig setuptools3
+
+RDEPENDS:${PN} = "python3-pyyaml python3-logging python3-compression python3-shell"
+
+BBCLASSEXTEND = "native nativesdk"
-- 
2.51.0


