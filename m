Return-Path: <majortomtosourcecontrol@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAFCECA100F
	for <webhook@archiver.kernel.org>; Mon, 22 Sep 2025 15:04:30 +0000 (UTC)
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
 by mx.groups.io with SMTP id smtpd.web10.54386.1758553466131226576
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 22 Sep 2025 08:04:26 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=Ns6BmEWQ;
 spf=pass (domain: gmail.com, ip: 209.85.166.44, mailfrom: majortomtosourcecontrol@gmail.com)
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-88432e1af6dso357099739f.2
        for <yocto-patches@lists.yoctoproject.org>; Mon, 22 Sep 2025 08:04:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758553465; x=1759158265; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nzgD0KbqO1vdxYRJ5rqXZhMeeUHQX8TUa6OVz/Ru9Rg=;
        b=Ns6BmEWQHi7DRX4B+hU0/L3hW4ZBxwWFjR47LfsTWlm0mtdwSrt3JuTdvIC0GWTVJr
         nvB6sB4mPyzjc1+f9VG5I9V0FdJ8wcjFqk5OcqsK8cF8Du0W+YAWKVMZMTiiUaCd+Mn0
         F2fGuO+mQPUeMtcv1r3QhBV2Lop36/qolXcisiwJ/D9d9TpUL8kToVA8+wEACghcIgbq
         U46b1rgcM9vzINcv263oTHmVeXKO1a2y+e2QUvtvagU4YNgXDVnKQ+7rSfyukBBc8Lkh
         6VqOpNzrFjOlL/lOzeoGR/FYuP8Ki+ge8H3mXzP3S9J9ij1y0M807Ep66Dmf8Dnncwm1
         D41A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758553465; x=1759158265;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=nzgD0KbqO1vdxYRJ5rqXZhMeeUHQX8TUa6OVz/Ru9Rg=;
        b=o5Tho3amFiWhK1ol6Wx1v3M+BBVoMJkp81zxHwtQpt2Gbl6SKCnrTCcCTVySsNS183
         CHIfIAxbTWCn0v81FYrmQSIyOTW1BrEvVpDL+T0F+FruhnO6jBBWDt2o90jrJCIKCPj5
         hemM6i48Yi3JEz3KRkb0XTeWdpaNpLw3YrkyQUBvuZRhXiZyh36muvue1PffhrGuRnUJ
         1dPVy/NJxjcNoheT5MoBFV/2hHkMUPT67pTzkIvdnOHRgWlKHHC0IwZ2qoaJTO/wcJKS
         y+B/1e3F7V1drZUVjQUipwMFtcI5ffByFUAf5C/d8pgnUiRbntvu5HNPq0uFmb+eefU2
         AoJg==
X-Gm-Message-State: AOJu0YwJ1V7UH9dFvenv713sO/kU5oVjIZuYubIsKqbkNmXEdjWMozWS
	cfp3AFjtLUgVxHskoldmb3TdhK9mpzntqIvs9pxajvwlFGuGxyT+KgrHnmgCWg==
X-Gm-Gg: ASbGncskRTMFbIpZ+Pd2D1DcjrG7oYXqtn0vCyWEKOhz5czrNbCkqMrpJpxjhHQESfp
	9FGqGMOlco8l8D3BsBkzEtt4jUfD2Bj/PS3vp0X3d92Y74jaiRWHEBFSvra9FTgfUl6TJYf8Qxh
	CPtATCfHL9Zlz3/GajIViZC6BS3DHNGwIqau/ur3+gMcV0Arx0zsqk+MmtdAm62NzKkeCFEBeiv
	j1hLBq9YhYDtZW5y/JnvPCX1J1RF+vjzvU04nU+dM1U2CzLRDLAjZIUIpAVG0LYFgHaXBYTWuvx
	ufxnv2Q3QAbqkTCX3JW6Ppw5pLrFjgkwuUWVcq4/I/FTrocjZ1uq/eOuei/8s1kJ9/dnMzhKOUI
	CiCyRAkUkJfrVkwkvTYMchTnZQYQyOXLJS6B8+4N+VnlP334APdN1NO8MooCJomraUFIH4Ztacq
	O5AzjMnreD
X-Google-Smtp-Source: AGHT+IEBKcJ0mdrRSvhO6V/fTYy+n7E1IlNj1vhWUD8Zo1MJcJUAlP4OlYqv0Fle3FPauBdryN7GJw==
X-Received: by 2002:a05:6e02:12c2:b0:424:708:77af with SMTP id e9e14a558f8ab-424819709b3mr189427375ab.20.1758553464063;
        Mon, 22 Sep 2025 08:04:24 -0700 (PDT)
Received: from [172.26.252.3] (174-16-207-42.hlrn.qwest.net. [174.16.207.42])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-424593dfb5bsm58692475ab.9.2025.09.22.08.04.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Sep 2025 08:04:23 -0700 (PDT)
Message-ID: <fc0c6979-568e-47a1-9906-f93e58312147@gmail.com>
Date: Mon, 22 Sep 2025 09:04:22 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: yocto-patches@lists.yoctoproject.org, scott.murray@konsulko.com,
 rybczynska@gmail.com
From: Clayton Casciato <majortomtosourcecontrol@gmail.com>
Subject: [meta-security][PATCH v2] suricata-update: add package to pull files
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 22 Sep 2025 15:04:30 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2228

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

Sponsor: 21SoftWare LLC

v2: 1.3.4 -> 1.3.6, drop "S", document target test results
v1: https://lists.yoctoproject.org/g/yocto-patches/message/1569

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

