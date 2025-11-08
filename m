Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C0FECCFA13
	for <webhook@archiver.kernel.org>; Sat,  8 Nov 2025 18:38:29 +0000 (UTC)
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.11434.1762627090875203210
 for <yocto-patches@lists.yoctoproject.org>;
 Sat, 08 Nov 2025 10:38:11 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=EgW4/UZ+;
 spf=pass (domain: konsulko.com, ip: 209.85.222.179, mailfrom: scott.murray@konsulko.com)
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-8a3eac7ca30so111663685a.2
        for <yocto-patches@lists.yoctoproject.org>; Sat, 08 Nov 2025 10:38:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1762627090; x=1763231890; darn=lists.yoctoproject.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=w7eU0UjUQnge+XFpmGOSJpu0szbRJqlaKXKVv4UU9zQ=;
        b=EgW4/UZ+OS47vroYqjzPgJIjHXva9qEOBl2wCh0WHQX6u6R0CtRk1njy08V6cK2aoY
         DkE1Wg+FXIfPIeeLJgX63xo6SD+v2WR0REG/MhfXMYw5tC5f7YJxpnBXjPO3hfGUweUH
         uuvCP6cR1XGlOxw+fKncFTGyLIxTdFJIldxjk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762627090; x=1763231890;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w7eU0UjUQnge+XFpmGOSJpu0szbRJqlaKXKVv4UU9zQ=;
        b=OmSTRwvrLrAhfpjhejjTRVy0GMRXj8yZU7qwkYsHoF1n+QlFfJnCqFp51d2YEomyxj
         N1Y/I0+njYE5iGWycA26LfgiVW2SQqkfdkRbW3Dg0ip8rVNOz4BsNRGtjdv6LkhMKa5j
         NGiTM9e7T0cOTx/NipxSlVDCZTu7nLG9ywNQ2U78XSHaM3CL0UqUHgf/GqQJ8/g0oroe
         pvRzcIGYDGEyY9AXyuCxmZSxfh7Ym+LQj6jIkL9uHYc3murMbX+u775Eb6oTwfV3IAqV
         nMy90rjFtrDm08qNmVILgbqklnrL4EFeCTEufCbzzsTs4Pt//zKf8YE27YazfVLTceZS
         NXBg==
X-Gm-Message-State: AOJu0YxgBb2gJ4fK2s2l0beIB6on2Xj1Ckbw/0I+NBD4N3OLbJORpqUn
	zLuUGzxHTEAZRKXlz3paoRXc4++jFa4vByZycfrGleU5lBs5S22I2tsGn32uGZWCWqU=
X-Gm-Gg: ASbGnctZ7M0j/vPT0G/oyXgbg2Ut8I2B3b2oaD/kiKDP7DwfQnUjgQj5PDzxbA7G1zf
	1eUM1CQhkSAe6mxIJPMiYcEblOdmr+GND3YJSSkcTgDSHoturF1ElxZ1r5lw3x/+zDnCN1OcNcr
	8KrZ0riAXse9R9qbV7RjuHCRMTGrPoG3ATitWAdTOFZXqv6cacC6gaCOTPb2xmu5hB4jCNkVdXo
	q9+pZfLX0htPB3OdS/6T+4IhvZHONUO8B7sjEYxcpppvV/nfk8hCtNFglRLSuzeQsY2GXr/EDOZ
	0cUfqbCQWE6b3WhY0iRONo/Dol0ENmJ4/7xF7sXJT0xIyzcX8YCPwG6h6RfpBHofCl6EQMv1VDm
	01fbHj9YPMnXkFdS2X+Au+eQihNMQjHv08341CLUNlzo4pt42qJRF3/y60EyLGvv3UCjpQYMlYs
	0ypQ/JN6/ESd2mr65YTxTlqDG901EJPymXO7QZ29uVRtBxLQ==
X-Google-Smtp-Source: AGHT+IHWZlapBvRw0GRna2Y3fVsIoZZks4U3IUWijobMwMO2IvYAz3InOUqGFkbJ4m06CwEI4W1QyQ==
X-Received: by 2002:a05:620a:7108:b0:8b2:2607:83d5 with SMTP id af79cd13be357-8b257f69903mr406281585a.75.1762627088722;
        Sat, 08 Nov 2025 10:38:08 -0800 (PST)
Received: from godzilla (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b26a2f4524sm26645485a.9.2025.11.08.10.38.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Nov 2025 10:38:07 -0800 (PST)
Date: Sat, 8 Nov 2025 13:38:06 -0500 (EST)
From: Scott Murray <scott.murray@konsulko.com>
To: Clayton Casciato <majortomtosourcecontrol@gmail.com>
cc: yocto-patches@lists.yoctoproject.org, rybczynska@gmail.com, 
    sdoshi@mvista.com
Subject: Re: [meta-security][PATCH] suricata: update to 7.0.12
In-Reply-To: <10994238-57a3-4100-ae0e-85ce34e93f25@gmail.com>
Message-ID: <5ab11d33-891e-e56a-2572-445f68e79fa2@konsulko.com>
References: <10994238-57a3-4100-ae0e-85ce34e93f25@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sat, 08 Nov 2025 18:38:29 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2434

On Tue, 4 Nov 2025, Clayton Casciato wrote:

> Update libhtp to required version 0.5.52
>
> https://suricata.io/2024/02/08/suricata-7-0-3-and-6-0-16-released/
> CVE-2024-23835
> CVE-2024-23836
> CVE-2024-24568

How attached are you to listing all the CVEs in the commit message?
I'm definitely going to prune the test information (perhaps put that
in a cover letter next time), but I'm tempted to omit the CVEs as
well to shorten the commit message, since they are listed in the
release note links.

Thanks,

Scott

> https://suricata.io/2024/03/19/suricata-7-0-4-and-6-0-17-released/
> CVE-2024-28870
>
> https://suricata.io/2024/04/23/suricata-7-0-5-and-6-0-19-released/
> CVE-2024-32663
> CVE-2024-32664
> CVE-2024-32867
>
> https://suricata.io/2024/06/27/suricata-7-0-6-and-6-0-20-released/
> CVE-2024-37151
> CVE-2024-38534
> CVE-2024-38535
> CVE-2024-38536
>
> https://suricata.io/2024/10/01/suricata-7-0-7-released/
> CVE-2024-47187
> CVE-2024-47188
> CVE-2024-47522
> CVE-2024-45795
> CVE-2024-45796
> CVE-2024-45797
>
> https://suricata.io/2024/12/12/suricata-7-0-8-released/
> CVE-2024-55605
> CVE-2024-55626
> CVE-2024-55627
> CVE-2024-55628
> CVE-2024-55629
>
> https://suricata.io/2025/03/18/suricata-7-0-9-released/
> CVE-2025-29915
> CVE-2025-29916
> CVE-2025-29917
> CVE-2025-29918
>
> https://suricata.io/2025/07/08/suricata-7-0-11-released/
> CVE-2025-53537
> CVE-2025-53538
>
> https://suricata.io/2025/09/16/suricata-8-0-1-and-7-0-12-released/
> CVE-2025-59147
>
> Target testing:
>
> root@beaglebone-yocto:~# systemctl status suricata
> * suricata.service - Suricata IDS/IDP daemon
>      Loaded: loaded (/usr/lib/systemd/system/suricata.service; enabled; preset: enabled)
>      Active: active (running) since Mon 2025-11-03 19:26:30 UTC; 15s ago
>  Invocation: bca75537dc684d7a91dda69b4f37f7b1
>        Docs: man:suricata(8)
>              man:suricatasc(8)
>              https://redmine.openinfosecfoundation.org/projects/suricata/wiki
>    Main PID: 262 (Suricata-Main)
>       Tasks: 7 (limit: 511)
>      Memory: 32.6M (peak: 32.6M)
>         CPU: 1.451s
>      CGroup: /system.slice/suricata.service
>              `-262 /usr/bin/suricata -c /etc/suricata/suricata.yaml -i eth0
>
> Nov 03 19:26:30 beaglebone-yocto systemd[1]: Started Suricata IDS/IDP daemon.
> Nov 03 19:26:31 beaglebone-yocto suricata[262]: i: suricata: This is Suricata version 7.0.12 RELEASE running in SYSTEM mode
> Nov 03 19:26:32 beaglebone-yocto suricata[262]: W: detect: No rule files match the pattern /var/lib/suricata/rules/suricata.rules
> Nov 03 19:26:32 beaglebone-yocto suricata[262]: W: detect: 1 rule files specified, but no rules were loaded!
> Nov 03 19:26:32 beaglebone-yocto suricata[262]: W: af-packet: eth0: AF_PACKET tpacket-v3 is recommended for non-inline operation
> Nov 03 19:26:32 beaglebone-yocto suricata[262]: i: threads: Threads created -> W: 1 FM: 1 FR: 1   Engine started.
>
> root@beaglebone-yocto:~# suricata-update
> 3/11/2025 -- 19:29:12 - <Info> -- Using data-directory /var/lib/suricata.
> 3/11/2025 -- 19:29:12 - <Info> -- Using Suricata configuration /etc/suricata/suricata.yaml
> 3/11/2025 -- 19:29:12 - <Info> -- Using /usr/share/suricata/rules for Suricata provided rules.
> 3/11/2025 -- 19:29:12 - <Info> -- Found Suricata version 7.0.12 at /bin/suricata.
> 3/11/2025 -- 19:29:12 - <Info> -- Loading /etc/suricata/suricata.yaml
> 3/11/2025 -- 19:29:12 - <Info> -- Disabling rules for protocol pgsql
> 3/11/2025 -- 19:29:12 - <Info> -- Disabling rules for protocol modbus
> 3/11/2025 -- 19:29:12 - <Info> -- Disabling rules for protocol dnp3
> 3/11/2025 -- 19:29:12 - <Info> -- Disabling rules for protocol enip
> 3/11/2025 -- 19:29:12 - <Info> -- No sources configured, will use Emerging Threats Open
> 3/11/2025 -- 19:29:12 - <Info> -- Last download less than 15 minutes ago. Not downloading https://rules.emergingthreats.net/open/suricata-7.0.12/emerging.rules.tar.gz.
> 3/11/2025 -- 19:29:14 - <Info> -- Loading distribution rule file /usr/share/suricata/rules/app-layer-events.rules
> 3/11/2025 -- 19:29:14 - <Info> -- Loading distribution rule file /usr/share/suricata/rules/decoder-events.rules
> 3/11/2025 -- 19:29:14 - <Info> -- Loading distribution rule file /usr/share/suricata/rules/dhcp-events.rules
> 3/11/2025 -- 19:29:14 - <Info> -- Loading distribution rule file /usr/share/suricata/rules/dnp3-events.rules
> 3/11/2025 -- 19:29:14 - <Info> -- Loading distribution rule file /usr/share/suricata/rules/dns-events.rules
> 3/11/2025 -- 19:29:14 - <Info> -- Loading distribution rule file /usr/share/suricata/rules/files.rules
> 3/11/2025 -- 19:29:14 - <Info> -- Loading distribution rule file /usr/share/suricata/rules/http2-events.rules
> 3/11/2025 -- 19:29:14 - <Info> -- Loading distribution rule file /usr/share/suricata/rules/http-events.rules
> 3/11/2025 -- 19:29:14 - <Info> -- Loading distribution rule file /usr/share/suricata/rules/ipsec-events.rules
> 3/11/2025 -- 19:29:14 - <Info> -- Loading distribution rule file /usr/share/suricata/rules/kerberos-events.rules
> 3/11/2025 -- 19:29:14 - <Info> -- Loading distribution rule file /usr/share/suricata/rules/modbus-events.rules
> 3/11/2025 -- 19:29:14 - <Info> -- Loading distribution rule file /usr/share/suricata/rules/mqtt-events.rules
> 3/11/2025 -- 19:29:14 - <Info> -- Loading distribution rule file /usr/share/suricata/rules/nfs-events.rules
> 3/11/2025 -- 19:29:14 - <Info> -- Loading distribution rule file /usr/share/suricata/rules/ntp-events.rules
> 3/11/2025 -- 19:29:14 - <Info> -- Loading distribution rule file /usr/share/suricata/rules/quic-events.rules
> 3/11/2025 -- 19:29:14 - <Info> -- Loading distribution rule file /usr/share/suricata/rules/rfb-events.rules
> 3/11/2025 -- 19:29:14 - <Info> -- Loading distribution rule file /usr/share/suricata/rules/smb-events.rules
> 3/11/2025 -- 19:29:14 - <Info> -- Loading distribution rule file /usr/share/suricata/rules/smtp-events.rules
> 3/11/2025 -- 19:29:14 - <Info> -- Loading distribution rule file /usr/share/suricata/rules/ssh-events.rules
> 3/11/2025 -- 19:29:14 - <Info> -- Loading distribution rule file /usr/share/suricata/rules/stream-events.rules
> 3/11/2025 -- 19:29:14 - <Info> -- Loading distribution rule file /usr/share/suricata/rules/tls-events.rules
> 3/11/2025 -- 19:29:15 - <Info> -- Ignoring file 9cb5ddbea94b65d0949efcba1127065e/rules/emerging-deleted.rules
> 3/11/2025 -- 19:29:44 - <Info> -- Loaded 62012 rules.
> 3/11/2025 -- 19:29:48 - <Info> -- Disabled 13 rules.
> 3/11/2025 -- 19:29:48 - <Info> -- Enabled 0 rules.
> 3/11/2025 -- 19:29:48 - <Info> -- Modified 0 rules.
> 3/11/2025 -- 19:29:48 - <Info> -- Dropped 0 rules.
> 3/11/2025 -- 19:29:49 - <Info> -- Enabled 136 rules for flowbit dependencies.
> 3/11/2025 -- 19:29:49 - <Info> -- Creating directory /var/lib/suricata/rules.
> 3/11/2025 -- 19:29:49 - <Info> -- Backing up current rules.
> 3/11/2025 -- 19:29:49 - <Info> -- Writing rules to /var/lib/suricata/rules/suricata.rules: total: 62012; enabled: 46205; added: 62012; removed 0; modified: 0
> 3/11/2025 -- 19:29:52 - <Info> -- Writing /var/lib/suricata/rules/classification.config
> 3/11/2025 -- 19:29:53 - <Info> -- Testing with suricata -T.
> 3/11/2025 -- 19:30:42 - <Info> -- Done.
>
> root@beaglebone-yocto:~# systemctl stop suricata
> virtio_net virtio2 eth0: left promiscuous mode
>
> root@beaglebone-yocto:~# systemctl start suricata
>
> root@beaglebone-yocto:~# systemctl status suricata
> * suricata.service - Suricata IDS/IDP daemon
>      Loaded: loaded (/usr/lib/systemd/system/suricata.service; enabled; preset: enabled)
>      Active: active (running) since Mon 2025-11-03 19:32:47 UTC; 1min 28s ago
>  Invocation: 78f35089e2924cf3a2749c4f7d68a1c8
>        Docs: man:suricata(8)
>              man:suricatasc(8)
>              https://redmine.openinfosecfoundation.org/projects/suricata/wiki
>    Main PID: 223 (Suricata-Main)
>       Tasks: 7 (limit: 4773)
>      Memory: 845.4M (peak: 903.4M)
>         CPU: 49.150s
>      CGroup: /system.slice/suricata.service
>              `-223 /usr/bin/suricata -c /etc/suricata/suricata.yaml -i eth0
>
> Nov 03 19:32:47 beaglebone-yocto systemd[1]: Started Suricata IDS/IDP daemon.
> Nov 03 19:32:47 beaglebone-yocto suricata[223]: i: suricata: This is Suricata version 7.0.12 RELEASE running in SYSTEM mode
> Nov 03 19:33:34 beaglebone-yocto suricata[223]: W: af-packet: eth0: AF_PACKET tpacket-v3 is recommended for non-inline operation
> Nov 03 19:33:34 beaglebone-yocto suricata[223]: i: threads: Threads created -> W: 1 FM: 1 FR: 1   Engine started.
>
> root@beaglebone-yocto:~# wget -O /tmp/arst http://testmynids.org/uid/index.html
> Connecting to testmynids.org (18.238.176.103:80)
> [...]
> '/tmp/arst' saved
>
> root@beaglebone-yocto:~# tail /var/log/suricata/fast.log
> 11/03/2025-19:36:39.374682  [**] [1:2100498:7] GPL ATTACK_RESPONSE id check returned root [**] [Classification: Potentially Bad Traffic] [Priority: 2] {TCP} 18.238.176.103:80 -> 10.0.2.15:42586
>
> Signed-off-by: Clayton Casciato <majortomtosourcecontrol@gmail.com>
> ---
> Sponsor: 21SoftWare LLC
>
> 7.0.10: https://lists.yoctoproject.org/g/yocto-patches/message/1572
>
>  ...kefile-from-using-its-own-rust-steps.patch |   40 +
>  .../suricata/files/CVE-2024-37151.patch       |   53 -
>  .../suricata/files/CVE-2024-38534.patch       |   44 -
>  .../suricata/files/CVE-2024-38535.patch       |   57 -
>  .../suricata/files/CVE-2024-38535_pre.patch   |  292 ----
>  .../suricata/files/CVE-2024-38536.patch       |   40 -
>  recipes-ids/suricata/files/fixup.patch        |   32 -
>  .../{libhtp_0.5.50.bb => libhtp_0.5.52.bb}    |    2 +-
>  recipes-ids/suricata/suricata-crates.inc      | 1509 ++++++++---------
>  .../{suricata_7.0.0.bb => suricata_7.0.12.bb} |    9 +-
>  10 files changed, 779 insertions(+), 1299 deletions(-)
>  create mode 100644 recipes-ids/suricata/files/0001-Skip-pkg-Makefile-from-using-its-own-rust-steps.patch
>  delete mode 100644 recipes-ids/suricata/files/CVE-2024-37151.patch
>  delete mode 100644 recipes-ids/suricata/files/CVE-2024-38534.patch
>  delete mode 100644 recipes-ids/suricata/files/CVE-2024-38535.patch
>  delete mode 100644 recipes-ids/suricata/files/CVE-2024-38535_pre.patch
>  delete mode 100644 recipes-ids/suricata/files/CVE-2024-38536.patch
>  delete mode 100644 recipes-ids/suricata/files/fixup.patch
>  rename recipes-ids/suricata/{libhtp_0.5.50.bb => libhtp_0.5.52.bb} (90%)
>  rename recipes-ids/suricata/{suricata_7.0.0.bb => suricata_7.0.12.bb} (95%)
>
> diff --git a/recipes-ids/suricata/files/0001-Skip-pkg-Makefile-from-using-its-own-rust-steps.patch b/recipes-ids/suricata/files/0001-Skip-pkg-Makefile-from-using-its-own-rust-steps.patch
> new file mode 100644
> index 0000000..12cb096
> --- /dev/null
> +++ b/recipes-ids/suricata/files/0001-Skip-pkg-Makefile-from-using-its-own-rust-steps.patch
> @@ -0,0 +1,40 @@
> +From a59708a9300df8116867ac77f7829f7fd647325e Mon Sep 17 00:00:00 2001
> +From: Clayton Casciato <ccasciato@21sw.us>
> +Date: Mon, 3 Nov 2025 10:30:26 -0700
> +Subject: [PATCH] Skip pkg Makefile from using its own rust steps
> +
> +Upstream-Status: Inappropriate [OE Specific]
> +
> +Signed-off-by: Armin Kuster <akuster808@gmail.com>
> +Signed-off-by: Clayton Casciato <majortomtosourcecontrol@gmail.com>
> +---
> + Makefile.am | 2 +-
> + Makefile.in | 2 +-
> + 2 files changed, 2 insertions(+), 2 deletions(-)
> +
> +diff --git a/Makefile.am b/Makefile.am
> +index d0d3d09..a572912 100644
> +--- a/Makefile.am
> ++++ b/Makefile.am
> +@@ -10,7 +10,7 @@ EXTRA_DIST = ChangeLog COPYING LICENSE suricata.yaml.in \
> + 	     scripts/generate-images.sh \
> + 	     scripts/docs-almalinux9-minimal-build.sh \
> + 	     scripts/docs-ubuntu-debian-minimal-build.sh
> +-SUBDIRS = $(HTP_DIR) rust src qa rules doc contrib etc python ebpf \
> ++SUBDIRS = $(HTP_DIR) src qa rules doc contrib etc python ebpf \
> +           $(SURICATA_UPDATE_DIR)
> +
> + CLEANFILES = stamp-h[0-9]*
> +diff --git a/Makefile.in b/Makefile.in
> +index 7a89353..3864613 100644
> +--- a/Makefile.in
> ++++ b/Makefile.in
> +@@ -428,7 +428,7 @@ EXTRA_DIST = ChangeLog COPYING LICENSE suricata.yaml.in \
> + 	     scripts/docs-almalinux9-minimal-build.sh \
> + 	     scripts/docs-ubuntu-debian-minimal-build.sh
> +
> +-SUBDIRS = $(HTP_DIR) rust src qa rules doc contrib etc python ebpf \
> ++SUBDIRS = $(HTP_DIR) src qa rules doc contrib etc python ebpf \
> +           $(SURICATA_UPDATE_DIR)
> +
> + CLEANFILES = stamp-h[0-9]*
> diff --git a/recipes-ids/suricata/files/CVE-2024-37151.patch b/recipes-ids/suricata/files/CVE-2024-37151.patch
> deleted file mode 100644
> index 7e5d8e2..0000000
> --- a/recipes-ids/suricata/files/CVE-2024-37151.patch
> +++ /dev/null
> @@ -1,53 +0,0 @@
> -From a6052dca1e27f3c8f96ec7be0fe7514c56a0d56f Mon Sep 17 00:00:00 2001
> -From: Victor Julien <vjulien@oisf.net>
> -Date: Tue, 4 Jun 2024 14:43:22 +0200
> -Subject: [PATCH 1/4] defrag: don't use completed tracker
> -
> -When a Tracker is set up for a IPID, frags come in for it and it's
> -reassembled and complete, the `DefragTracker::remove` flag is set. This
> -is mean to tell the hash cleanup code to recyle the tracker and to let
> -the lookup code skip the tracker during lookup.
> -
> -A logic error lead to the following scenario:
> -
> -1. there are sufficient frag trackers to make sure the hash table is
> -   filled with trackers
> -2. frags for a Packet with IPID X are processed correctly (X1)
> -3. frags for a new Packet that also has IPID X come in quickly after the
> -   first (X2).
> -4. during the lookup, the frag for X2 hashes to a hash row that holds
> -   more than one tracker
> -5. as the trackers in hash row are evaluated, it finds the tracker for
> -   X1, but since the `remove` bit is not checked, it is returned as the
> -   tracker for X2.
> -6. reassembly fails, as the tracker is already complete
> -
> -The logic error is that only for the first tracker in a row the `remove`
> -bit was checked, leading to reuse to a closed tracker if there were more
> -trackers in the hash row.
> -
> -Ticket: #7042.
> -
> -Upstream-Status: Backport from [https://github.com/OISF/suricata/commit/aab7f35c76721df19403a7c0c0025feae12f3b6b]
> -CVE: CVE-2024-37151
> -Signed-off-by: Siddharth Doshi <sdoshi@mvista.com>
> ----
> - src/defrag-hash.c | 2 +-
> - 1 file changed, 1 insertion(+), 1 deletion(-)
> -
> -diff --git a/src/defrag-hash.c b/src/defrag-hash.c
> -index 2f19ce2..87d40f9 100644
> ---- a/src/defrag-hash.c
> -+++ b/src/defrag-hash.c
> -@@ -591,7 +591,7 @@ DefragTracker *DefragGetTrackerFromHash (Packet *p)
> -                 return dt;
> -             }
> -
> --            if (DefragTrackerCompare(dt, p) != 0) {
> -+            if (!dt->remove && DefragTrackerCompare(dt, p) != 0) {
> -                 /* we found our tracker, lets put it on top of the
> -                  * hash list -- this rewards active trackers */
> -                 if (dt->hnext) {
> ---
> -2.44.0
> -
> diff --git a/recipes-ids/suricata/files/CVE-2024-38534.patch b/recipes-ids/suricata/files/CVE-2024-38534.patch
> deleted file mode 100644
> index 14a958c..0000000
> --- a/recipes-ids/suricata/files/CVE-2024-38534.patch
> +++ /dev/null
> @@ -1,44 +0,0 @@
> -From f1645ea911d4e90b1be8ee5863e8e1a665079cce Mon Sep 17 00:00:00 2001
> -From: Philippe Antoine <pantoine@oisf.net>
> -Date: Thu, 25 Apr 2024 21:24:33 +0200
> -Subject: [PATCH 2/4] modbus: abort flow parsing on flood
> -
> -Ticket: 6987
> -
> -Let's not spend more resources for a flow which is trying to
> -make us do it...
> -
> -(cherry picked from commit 37509e8e0ed097f8e0174df754835ac60584fc72)
> -
> -Upstream-Status: Backport from [https://github.com/OISF/suricata/commit/a753cdbe84caee3b66d0bf49b2712d29a50d67ae]
> -CVE: CVE-2024-38534
> -Signed-off-by: Siddharth Doshi <sdoshi@mvista.com>
> ----
> - rust/src/modbus/modbus.rs | 4 ++--
> - 1 file changed, 2 insertions(+), 2 deletions(-)
> -
> -diff --git a/rust/src/modbus/modbus.rs b/rust/src/modbus/modbus.rs
> -index 246e9ca..d2f7c6b 100644
> ---- a/rust/src/modbus/modbus.rs
> -+++ b/rust/src/modbus/modbus.rs
> -@@ -189,7 +189,7 @@ impl ModbusState {
> -                                 None => {
> -                                     let mut tx = match self.new_tx() {
> -                                         Some(tx) => tx,
> --                                        None => return AppLayerResult::ok(),
> -+                                        None => return AppLayerResult::err(),
> -                                     };
> -                                     tx.set_events_from_flags(&msg.error_flags);
> -                                     tx.request = Some(msg);
> -@@ -215,7 +215,7 @@ impl ModbusState {
> -                             None => {
> -                                 let mut tx = match self.new_tx() {
> -                                     Some(tx) => tx,
> --                                    None => return AppLayerResult::ok(),
> -+                                    None => return AppLayerResult::err(),
> -                                 };
> -                                 if msg
> -                                     .access_type
> ---
> -2.44.0
> -
> diff --git a/recipes-ids/suricata/files/CVE-2024-38535.patch b/recipes-ids/suricata/files/CVE-2024-38535.patch
> deleted file mode 100644
> index 7ac72c8..0000000
> --- a/recipes-ids/suricata/files/CVE-2024-38535.patch
> +++ /dev/null
> @@ -1,57 +0,0 @@
> -From 6b00dc36d7527f051c2346f03d20f8d9e5a60138 Mon Sep 17 00:00:00 2001
> -From: Philippe Antoine <pantoine@oisf.net>
> -Date: Mon, 17 Jun 2024 16:30:49 +0200
> -Subject: [PATCH 3/4] http2: do not expand duplicate headers
> -
> -Ticket: 7104
> -
> -As this can cause a big mamory allocation due to the quadratic
> -nature of the HPACK compression.
> -
> -(cherry picked from commit 5bd17934df321b88f502d48afdd6cc8bad4787a7)
> -
> -Upstream-Status: Backport from [https://github.com/OISF/suricata/commit/c82fa5ca0d1ce0bd8f936e0b860707a6571373b2]
> -CVE: CVE-2024-38535
> -Signed-off-by: Siddharth Doshi <sdoshi@mvista.com>
> ----
> - rust/src/http2/detect.rs | 8 ++++----
> - 1 file changed, 4 insertions(+), 4 deletions(-)
> -
> -diff --git a/rust/src/http2/detect.rs b/rust/src/http2/detect.rs
> -index 99261ad..9c2f8ab 100644
> ---- a/rust/src/http2/detect.rs
> -+++ b/rust/src/http2/detect.rs
> -@@ -432,11 +432,11 @@ pub fn http2_frames_get_header_value_vec(
> -                     if found == 0 {
> -                         vec.extend_from_slice(&block.value);
> -                         found = 1;
> --                    } else if found == 1 {
> -+                    } else if found == 1 && Rc::strong_count(&block.name) <= 2 {
> -                         vec.extend_from_slice(&[b',', b' ']);
> -                         vec.extend_from_slice(&block.value);
> -                         found = 2;
> --                    } else {
> -+                    } else if Rc::strong_count(&block.name) <= 2 {
> -                         vec.extend_from_slice(&[b',', b' ']);
> -                         vec.extend_from_slice(&block.value);
> -                     }
> -@@ -469,14 +469,14 @@ fn http2_frames_get_header_value<'a>(
> -                     if found == 0 {
> -                         single = Ok(&block.value);
> -                         found = 1;
> --                    } else if found == 1 {
> -+                    } else if found == 1 && Rc::strong_count(&block.name) <= 2 {
> -                         if let Ok(s) = single {
> -                             vec.extend_from_slice(s);
> -                         }
> -                         vec.extend_from_slice(&[b',', b' ']);
> -                         vec.extend_from_slice(&block.value);
> -                         found = 2;
> --                    } else {
> -+                    } else if Rc::strong_count(&block.name) <= 2 {
> -                         vec.extend_from_slice(&[b',', b' ']);
> -                         vec.extend_from_slice(&block.value);
> -                     }
> ---
> -2.44.0
> -
> diff --git a/recipes-ids/suricata/files/CVE-2024-38535_pre.patch b/recipes-ids/suricata/files/CVE-2024-38535_pre.patch
> deleted file mode 100644
> index 2aa42c4..0000000
> --- a/recipes-ids/suricata/files/CVE-2024-38535_pre.patch
> +++ /dev/null
> @@ -1,292 +0,0 @@
> -From 390f09692eb99809c679d3f350c7cc185d163e1a Mon Sep 17 00:00:00 2001
> -From: Philippe Antoine <pantoine@oisf.net>
> -Date: Wed, 27 Mar 2024 14:33:54 +0100
> -Subject: [PATCH] http2: use a reference counter for headers
> -
> -Ticket: 6892
> -
> -As HTTP hpack header compression allows one single byte to
> -express a previously seen arbitrary-size header block (name+value)
> -we should avoid to copy the vectors data, but just point
> -to the same data, while reamining memory safe, even in the case
> -of later headers eviction from the dybnamic table.
> -
> -Rust std solution is Rc, and the use of clone, so long as the
> -data is accessed by only one thread.
> -
> -Note: This patch is needed to patch CVE-2024-38535 as  it defines Rc.
> -Upstream-Status: Backport from [https://github.com/OISF/suricata/commit/390f09692eb99809c679d3f350c7cc185d163e1a]
> -Signed-off-by: Siddharth Doshi <sdoshi@mvista.com>
> ----
> - rust/src/http2/detect.rs | 19 +++++++------
> - rust/src/http2/http2.rs  |  2 +-
> - rust/src/http2/parser.rs | 61 +++++++++++++++++++++-------------------
> - 3 files changed, 43 insertions(+), 39 deletions(-)
> -
> -diff --git a/rust/src/http2/detect.rs b/rust/src/http2/detect.rs
> -index 9c2f8ab..e068a17 100644
> ---- a/rust/src/http2/detect.rs
> -+++ b/rust/src/http2/detect.rs
> -@@ -23,6 +23,7 @@ use crate::core::Direction;
> - use crate::detect::uint::{detect_match_uint, DetectUintData};
> - use std::ffi::CStr;
> - use std::str::FromStr;
> -+use std::rc::Rc;
> -
> - fn http2_tx_has_frametype(
> -     tx: &mut HTTP2Transaction, direction: Direction, value: u8,
> -@@ -404,7 +405,7 @@ fn http2_frames_get_header_firstvalue<'a>(
> -     for frame in frames {
> -         if let Some(blocks) = http2_header_blocks(frame) {
> -             for block in blocks.iter() {
> --                if block.name == name.as_bytes() {
> -+                if block.name.as_ref() == name.as_bytes() {
> -                     return Ok(&block.value);
> -                 }
> -             }
> -@@ -428,7 +429,7 @@ pub fn http2_frames_get_header_value_vec(
> -     for frame in frames {
> -         if let Some(blocks) = http2_header_blocks(frame) {
> -             for block in blocks.iter() {
> --                if block.name == name.as_bytes() {
> -+                if block.name.as_ref() == name.as_bytes() {
> -                     if found == 0 {
> -                         vec.extend_from_slice(&block.value);
> -                         found = 1;
> -@@ -465,7 +466,7 @@ fn http2_frames_get_header_value<'a>(
> -     for frame in frames {
> -         if let Some(blocks) = http2_header_blocks(frame) {
> -             for block in blocks.iter() {
> --                if block.name == name.as_bytes() {
> -+                if block.name.as_ref() == name.as_bytes() {
> -                     if found == 0 {
> -                         single = Ok(&block.value);
> -                         found = 1;
> -@@ -905,8 +906,8 @@ fn http2_tx_set_header(state: &mut HTTP2State, name: &[u8], input: &[u8]) {
> -     };
> -     let mut blocks = Vec::new();
> -     let b = parser::HTTP2FrameHeaderBlock {
> --        name: name.to_vec(),
> --        value: input.to_vec(),
> -+        name: Rc::new(name.to_vec()),
> -+        value: Rc::new(input.to_vec()),
> -         error: parser::HTTP2HeaderDecodeStatus::HTTP2HeaderDecodeSuccess,
> -         sizeupdate: 0,
> -     };
> -@@ -1061,15 +1062,15 @@ mod tests {
> -         };
> -         let mut blocks = Vec::new();
> -         let b = parser::HTTP2FrameHeaderBlock {
> --            name: "Host".as_bytes().to_vec(),
> --            value: "abc.com".as_bytes().to_vec(),
> -+            name: "Host".as_bytes().to_vec().into(),
> -+            value: "abc.com".as_bytes().to_vec().into(),
> -             error: parser::HTTP2HeaderDecodeStatus::HTTP2HeaderDecodeSuccess,
> -             sizeupdate: 0,
> -         };
> -         blocks.push(b);
> -         let b2 = parser::HTTP2FrameHeaderBlock {
> --            name: "Host".as_bytes().to_vec(),
> --            value: "efg.net".as_bytes().to_vec(),
> -+            name: "Host".as_bytes().to_vec().into(),
> -+            value: "efg.net".as_bytes().to_vec().into(),
> -             error: parser::HTTP2HeaderDecodeStatus::HTTP2HeaderDecodeSuccess,
> -             sizeupdate: 0,
> -         };
> -diff --git a/rust/src/http2/http2.rs b/rust/src/http2/http2.rs
> -index 326030f..d14ca06 100644
> ---- a/rust/src/http2/http2.rs
> -+++ b/rust/src/http2/http2.rs
> -@@ -204,7 +204,7 @@ impl HTTP2Transaction {
> -
> -     fn handle_headers(&mut self, blocks: &[parser::HTTP2FrameHeaderBlock], dir: Direction) {
> -         for block in blocks {
> --            if block.name == b"content-encoding" {
> -+            if block.name.as_ref() == b"content-encoding" {
> -                 self.decoder.http2_encoding_fromvec(&block.value, dir);
> -             }
> -         }
> -diff --git a/rust/src/http2/parser.rs b/rust/src/http2/parser.rs
> -index adabeb2..1a46437 100644
> ---- a/rust/src/http2/parser.rs
> -+++ b/rust/src/http2/parser.rs
> -@@ -30,6 +30,7 @@ use nom7::sequence::tuple;
> - use nom7::{Err, IResult};
> - use std::fmt;
> - use std::str::FromStr;
> -+use std::rc::Rc;
> -
> - #[repr(u8)]
> - #[derive(Clone, Copy, PartialEq, Eq, FromPrimitive, Debug)]
> -@@ -295,8 +296,8 @@ fn http2_frame_header_static(n: u64, dyn_headers: &HTTP2DynTable) -> Option<HTTP
> -     };
> -     if !name.is_empty() {
> -         return Some(HTTP2FrameHeaderBlock {
> --            name: name.as_bytes().to_vec(),
> --            value: value.as_bytes().to_vec(),
> -+            name: Rc::new(name.as_bytes().to_vec()),
> -+            value: Rc::new(value.as_bytes().to_vec()),
> -             error: HTTP2HeaderDecodeStatus::HTTP2HeaderDecodeSuccess,
> -             sizeupdate: 0,
> -         });
> -@@ -304,23 +305,23 @@ fn http2_frame_header_static(n: u64, dyn_headers: &HTTP2DynTable) -> Option<HTTP
> -         //use dynamic table
> -         if n == 0 {
> -             return Some(HTTP2FrameHeaderBlock {
> --                name: Vec::new(),
> --                value: Vec::new(),
> -+                name: Rc::new(Vec::new()),
> -+                value: Rc::new(Vec::new()),
> -                 error: HTTP2HeaderDecodeStatus::HTTP2HeaderDecodeIndex0,
> -                 sizeupdate: 0,
> -             });
> -         } else if dyn_headers.table.len() + HTTP2_STATIC_HEADERS_NUMBER < n as usize {
> -             return Some(HTTP2FrameHeaderBlock {
> --                name: Vec::new(),
> --                value: Vec::new(),
> -+                name: Rc::new(Vec::new()),
> -+                value: Rc::new(Vec::new()),
> -                 error: HTTP2HeaderDecodeStatus::HTTP2HeaderDecodeNotIndexed,
> -                 sizeupdate: 0,
> -             });
> -         } else {
> -             let indyn = dyn_headers.table.len() - (n as usize - HTTP2_STATIC_HEADERS_NUMBER);
> -             let headcopy = HTTP2FrameHeaderBlock {
> --                name: dyn_headers.table[indyn].name.to_vec(),
> --                value: dyn_headers.table[indyn].value.to_vec(),
> -+                name: dyn_headers.table[indyn].name.clone(),
> -+                value: dyn_headers.table[indyn].value.clone(),
> -                 error: HTTP2HeaderDecodeStatus::HTTP2HeaderDecodeSuccess,
> -                 sizeupdate: 0,
> -             };
> -@@ -348,8 +349,10 @@ impl fmt::Display for HTTP2HeaderDecodeStatus {
> -
> - #[derive(Clone, Debug)]
> - pub struct HTTP2FrameHeaderBlock {
> --    pub name: Vec<u8>,
> --    pub value: Vec<u8>,
> -+    // Use Rc reference counted so that indexed headers do not get copied.
> -+    // Otherwise, this leads to quadratic complexity in memory occupation.
> -+    pub name: Rc<Vec<u8>>,
> -+    pub value: Rc<Vec<u8>>,
> -     pub error: HTTP2HeaderDecodeStatus,
> -     pub sizeupdate: u64,
> - }
> -@@ -391,7 +394,7 @@ fn http2_parse_headers_block_literal_common<'a>(
> - ) -> IResult<&'a [u8], HTTP2FrameHeaderBlock> {
> -     let (i3, name, error) = if index == 0 {
> -         match http2_parse_headers_block_string(input) {
> --            Ok((r, n)) => Ok((r, n, HTTP2HeaderDecodeStatus::HTTP2HeaderDecodeSuccess)),
> -+            Ok((r, n)) => Ok((r, Rc::new(n), HTTP2HeaderDecodeStatus::HTTP2HeaderDecodeSuccess)),
> -             Err(e) => Err(e),
> -         }
> -     } else {
> -@@ -403,7 +406,7 @@ fn http2_parse_headers_block_literal_common<'a>(
> -             )),
> -             None => Ok((
> -                 input,
> --                Vec::new(),
> -+                Rc::new(Vec::new()),
> -                 HTTP2HeaderDecodeStatus::HTTP2HeaderDecodeNotIndexed,
> -             )),
> -         }
> -@@ -413,7 +416,7 @@ fn http2_parse_headers_block_literal_common<'a>(
> -         i4,
> -         HTTP2FrameHeaderBlock {
> -             name,
> --            value,
> -+            value: Rc::new(value),
> -             error,
> -             sizeupdate: 0,
> -         },
> -@@ -435,8 +438,8 @@ fn http2_parse_headers_block_literal_incindex<'a>(
> -     match r {
> -         Ok((r, head)) => {
> -             let headcopy = HTTP2FrameHeaderBlock {
> --                name: head.name.to_vec(),
> --                value: head.value.to_vec(),
> -+                name: head.name.clone(),
> -+                value: head.value.clone(),
> -                 error: head.error,
> -                 sizeupdate: 0,
> -             };
> -@@ -556,8 +559,8 @@ fn http2_parse_headers_block_dynamic_size<'a>(
> -     return Ok((
> -         i3,
> -         HTTP2FrameHeaderBlock {
> --            name: Vec::new(),
> --            value: Vec::new(),
> -+            name: Rc::new(Vec::new()),
> -+            value: Rc::new(Vec::new()),
> -             error: HTTP2HeaderDecodeStatus::HTTP2HeaderDecodeSizeUpdate,
> -             sizeupdate: maxsize2,
> -         },
> -@@ -614,8 +617,8 @@ fn http2_parse_headers_blocks<'a>(
> -                 // if we error from http2_parse_var_uint, we keep the first parsed headers
> -                 if err.code == ErrorKind::LengthValue {
> -                     blocks.push(HTTP2FrameHeaderBlock {
> --                        name: Vec::new(),
> --                        value: Vec::new(),
> -+                        name: Rc::new(Vec::new()),
> -+                        value: Rc::new(Vec::new()),
> -                         error: HTTP2HeaderDecodeStatus::HTTP2HeaderDecodeIntegerOverflow,
> -                         sizeupdate: 0,
> -                     });
> -@@ -765,8 +768,8 @@ mod tests {
> -         match r0 {
> -             Ok((remainder, hd)) => {
> -                 // Check the first message.
> --                assert_eq!(hd.name, ":method".as_bytes().to_vec());
> --                assert_eq!(hd.value, "GET".as_bytes().to_vec());
> -+                assert_eq!(hd.name, ":method".as_bytes().to_vec().into());
> -+                assert_eq!(hd.value, "GET".as_bytes().to_vec().into());
> -                 // And we should have no bytes left.
> -                 assert_eq!(remainder.len(), 0);
> -             }
> -@@ -782,8 +785,8 @@ mod tests {
> -         match r1 {
> -             Ok((remainder, hd)) => {
> -                 // Check the first message.
> --                assert_eq!(hd.name, "accept".as_bytes().to_vec());
> --                assert_eq!(hd.value, "*/*".as_bytes().to_vec());
> -+                assert_eq!(hd.name, "accept".as_bytes().to_vec().into());
> -+                assert_eq!(hd.value, "*/*".as_bytes().to_vec().into());
> -                 // And we should have no bytes left.
> -                 assert_eq!(remainder.len(), 0);
> -                 assert_eq!(dynh.table.len(), 1);
> -@@ -802,8 +805,8 @@ mod tests {
> -         match result {
> -             Ok((remainder, hd)) => {
> -                 // Check the first message.
> --                assert_eq!(hd.name, ":authority".as_bytes().to_vec());
> --                assert_eq!(hd.value, "localhost:3000".as_bytes().to_vec());
> -+                assert_eq!(hd.name, ":authority".as_bytes().to_vec().into());
> -+                assert_eq!(hd.value, "localhost:3000".as_bytes().to_vec().into());
> -                 // And we should have no bytes left.
> -                 assert_eq!(remainder.len(), 0);
> -                 assert_eq!(dynh.table.len(), 2);
> -@@ -820,8 +823,8 @@ mod tests {
> -         match r3 {
> -             Ok((remainder, hd)) => {
> -                 // same as before
> --                assert_eq!(hd.name, ":authority".as_bytes().to_vec());
> --                assert_eq!(hd.value, "localhost:3000".as_bytes().to_vec());
> -+                assert_eq!(hd.name, ":authority".as_bytes().to_vec().into());
> -+                assert_eq!(hd.value, "localhost:3000".as_bytes().to_vec().into());
> -                 // And we should have no bytes left.
> -                 assert_eq!(remainder.len(), 0);
> -                 assert_eq!(dynh.table.len(), 2);
> -@@ -856,8 +859,8 @@ mod tests {
> -         match r2 {
> -             Ok((remainder, hd)) => {
> -                 // Check the first message.
> --                assert_eq!(hd.name, ":path".as_bytes().to_vec());
> --                assert_eq!(hd.value, "/doc/manual/html/index.html".as_bytes().to_vec());
> -+                assert_eq!(hd.name, ":path".as_bytes().to_vec().into());
> -+                assert_eq!(hd.value, "/doc/manual/html/index.html".as_bytes().to_vec().into());
> -                 // And we should have no bytes left.
> -                 assert_eq!(remainder.len(), 0);
> -                 assert_eq!(dynh.table.len(), 2);
> ---
> -2.44.0
> -
> diff --git a/recipes-ids/suricata/files/CVE-2024-38536.patch b/recipes-ids/suricata/files/CVE-2024-38536.patch
> deleted file mode 100644
> index 2d4b3d7..0000000
> --- a/recipes-ids/suricata/files/CVE-2024-38536.patch
> +++ /dev/null
> @@ -1,40 +0,0 @@
> -From 4026bca7f04c419dd3f3ba17a1af17bbcbcf18bc Mon Sep 17 00:00:00 2001
> -From: Philippe Antoine <pantoine@oisf.net>
> -Date: Fri, 17 May 2024 09:39:52 +0200
> -Subject: [PATCH 4/4] http: fix nul deref on memcap reached
> -
> -HttpRangeOpenFileAux may return NULL in different cases, including
> -when memcap is reached.
> -But is only caller did not check it before calling HttpRangeAppendData
> -which would dereference the NULL value.
> -
> -Ticket: 7029
> -(cherry picked from commit fd262df457f67f2174752dd6505ba2ed5911fd96)
> -
> -Upstream-Status: Backport from [https://github.com/OISF/suricata/commit/2bd3bd0e318f19008e9fe068ab17277c530ffb92]
> -CVE: CVE-2024-38536
> -Signed-off-by: Siddharth Doshi <sdoshi@mvista.com>
> ----
> - src/app-layer-htp-range.c | 6 ++++--
> - 1 file changed, 4 insertions(+), 2 deletions(-)
> -
> -diff --git a/src/app-layer-htp-range.c b/src/app-layer-htp-range.c
> -index 3cdde35..f0d75a9 100644
> ---- a/src/app-layer-htp-range.c
> -+++ b/src/app-layer-htp-range.c
> -@@ -351,8 +351,10 @@ static HttpRangeContainerBlock *HttpRangeOpenFile(HttpRangeContainerFile *c, uin
> - {
> -     HttpRangeContainerBlock *r =
> -             HttpRangeOpenFileAux(c, start, end, total, sbcfg, name, name_len, flags);
> --    if (HttpRangeAppendData(sbcfg, r, data, len) < 0) {
> --        SCLogDebug("Failed to append data while opening");
> -+    if (r) {
> -+        if (HttpRangeAppendData(sbcfg, r, data, len) < 0) {
> -+            SCLogDebug("Failed to append data while opening");
> -+        }
> -     }
> -     return r;
> - }
> ---
> -2.44.0
> -
> diff --git a/recipes-ids/suricata/files/fixup.patch b/recipes-ids/suricata/files/fixup.patch
> deleted file mode 100644
> index 0b2ae7c..0000000
> --- a/recipes-ids/suricata/files/fixup.patch
> +++ /dev/null
> @@ -1,32 +0,0 @@
> -Skip pkg Makefile from using its own rust steps
> -
> -Upstream-Status: Inappropriate [OE Specific]
> -
> -Signed-off-by: Armin Kuster <akuster808@gmail.com>
> -
> -Index: suricata-7.0.0/Makefile.in
> -===================================================================
> ---- suricata-7.0.0.orig/Makefile.in
> -+++ suricata-7.0.0/Makefile.in
> -@@ -424,7 +424,7 @@ EXTRA_DIST = ChangeLog COPYING LICENSE s
> - 	     acsite.m4 \
> - 	     scripts/generate-images.sh
> -
> --SUBDIRS = $(HTP_DIR) rust src qa rules doc contrib etc python ebpf \
> -+SUBDIRS = $(HTP_DIR) src qa rules doc contrib etc python ebpf \
> -           $(SURICATA_UPDATE_DIR)
> -
> - CLEANFILES = stamp-h[0-9]*
> -Index: suricata-7.0.0/Makefile.am
> -===================================================================
> ---- suricata-7.0.0.orig/Makefile.am
> -+++ suricata-7.0.0/Makefile.am
> -@@ -8,7 +8,7 @@ EXTRA_DIST = ChangeLog COPYING LICENSE s
> - 	     lua \
> - 	     acsite.m4 \
> - 	     scripts/generate-images.sh
> --SUBDIRS = $(HTP_DIR) rust src qa rules doc contrib etc python ebpf \
> -+SUBDIRS = $(HTP_DIR) src qa rules doc contrib etc python ebpf \
> -           $(SURICATA_UPDATE_DIR)
> -
> - CLEANFILES = stamp-h[0-9]*
> diff --git a/recipes-ids/suricata/libhtp_0.5.50.bb b/recipes-ids/suricata/libhtp_0.5.52.bb
> similarity index 90%
> rename from recipes-ids/suricata/libhtp_0.5.50.bb
> rename to recipes-ids/suricata/libhtp_0.5.52.bb
> index 7695539..f5e7138 100644
> --- a/recipes-ids/suricata/libhtp_0.5.50.bb
> +++ b/recipes-ids/suricata/libhtp_0.5.52.bb
> @@ -5,7 +5,7 @@ require suricata.inc
>  LIC_FILES_CHKSUM = "file://LICENSE;beginline=1;endline=2;md5=596ab7963a1a0e5198e5a1c4aa621843"
>
>  SRC_URI = "git://github.com/OISF/libhtp.git;protocol=https;branch=0.5.x"
> -SRCREV = "ebe480be4a5f3bb1d44be6a9a6c2755bd8ef7e71"
> +SRCREV = "314ca7360e141a1e40be58707b3abeefe32258c9"
>
>  DEPENDS = "zlib"
>
> diff --git a/recipes-ids/suricata/suricata-crates.inc b/recipes-ids/suricata/suricata-crates.inc
> index 386d8d1..0755302 100644
> --- a/recipes-ids/suricata/suricata-crates.inc
> +++ b/recipes-ids/suricata/suricata-crates.inc
> @@ -1,128 +1,547 @@
>  # Autogenerated with 'bitbake -c update_crates suricata'
>
>  # from rust/Cargo.lock
> -SRC_URI += " \
> -    crate://crates.io/adler/1.0.2 \
> -    crate://crates.io/aead/0.4.3 \
> -    crate://crates.io/aes/0.7.5 \
> -    crate://crates.io/aes-gcm/0.9.4 \
> -    crate://crates.io/aho-corasick/0.7.20 \
> -    crate://crates.io/alloc-no-stdlib/2.0.4 \
> -    crate://crates.io/alloc-stdlib/0.2.2 \
> -    crate://crates.io/asn1-rs/0.5.2 \
> -    crate://crates.io/asn1-rs-derive/0.4.0 \
> -    crate://crates.io/asn1-rs-impl/0.1.0 \
> -    crate://crates.io/autocfg/1.1.0 \
> -    crate://crates.io/base64/0.13.1 \
> -    crate://crates.io/bendy/0.3.3 \
> -    crate://crates.io/bitflags/1.2.1 \
> -    crate://crates.io/block-buffer/0.10.4 \
> -    crate://crates.io/brotli/3.3.4 \
> -    crate://crates.io/brotli-decompressor/2.3.4 \
> -    crate://crates.io/build_const/0.2.2 \
> -    crate://crates.io/byteorder/1.4.3 \
> -    crate://crates.io/cfg-if/1.0.0 \
> -    crate://crates.io/cipher/0.3.0 \
> -    crate://crates.io/cpufeatures/0.2.9 \
> -    crate://crates.io/crc/1.8.1 \
> -    crate://crates.io/crc32fast/1.3.2 \
> -    crate://crates.io/crypto-common/0.1.6 \
> -    crate://crates.io/ctr/0.8.0 \
> -    crate://crates.io/data-encoding/2.4.0 \
> -    crate://crates.io/der-oid-macro/0.5.0 \
> -    crate://crates.io/der-parser/6.0.1 \
> -    crate://crates.io/der-parser/8.2.0 \
> -    crate://crates.io/digest/0.10.7 \
> -    crate://crates.io/displaydoc/0.2.4 \
> -    crate://crates.io/enum_primitive/0.1.1 \
> -    crate://crates.io/failure/0.1.8 \
> -    crate://crates.io/failure_derive/0.1.8 \
> -    crate://crates.io/flate2/1.0.26 \
> -    crate://crates.io/generic-array/0.14.7 \
> -    crate://crates.io/getrandom/0.2.10 \
> -    crate://crates.io/ghash/0.4.4 \
> -    crate://crates.io/hex/0.4.3 \
> -    crate://crates.io/hkdf/0.12.3 \
> -    crate://crates.io/hmac/0.12.1 \
> -    crate://crates.io/ipsec-parser/0.7.0 \
> -    crate://crates.io/itoa/1.0.8 \
> -    crate://crates.io/kerberos-parser/0.7.1 \
> -    crate://crates.io/lazy_static/1.4.0 \
> -    crate://crates.io/libc/0.2.147 \
> -    crate://crates.io/lzma-rs/0.2.0 \
> -    crate://crates.io/md-5/0.10.5 \
> -    crate://crates.io/memchr/2.4.1 \
> -    crate://crates.io/minimal-lexical/0.2.1 \
> -    crate://crates.io/miniz_oxide/0.7.1 \
> -    crate://crates.io/nom/7.1.3 \
> -    crate://crates.io/nom-derive/0.10.1 \
> -    crate://crates.io/nom-derive-impl/0.10.1 \
> -    crate://crates.io/ntp-parser/0.6.0 \
> -    crate://crates.io/num/0.2.1 \
> -    crate://crates.io/num-bigint/0.2.6 \
> -    crate://crates.io/num-bigint/0.4.3 \
> -    crate://crates.io/num-complex/0.2.4 \
> -    crate://crates.io/num-derive/0.2.5 \
> -    crate://crates.io/num-integer/0.1.45 \
> -    crate://crates.io/num-iter/0.1.43 \
> -    crate://crates.io/num-rational/0.2.4 \
> -    crate://crates.io/num-traits/0.1.43 \
> -    crate://crates.io/num-traits/0.2.15 \
> -    crate://crates.io/num_enum/0.5.11 \
> -    crate://crates.io/num_enum_derive/0.5.11 \
> -    crate://crates.io/num_threads/0.1.6 \
> -    crate://crates.io/oid-registry/0.6.1 \
> -    crate://crates.io/opaque-debug/0.3.0 \
> -    crate://crates.io/phf/0.10.1 \
> -    crate://crates.io/phf_codegen/0.10.0 \
> -    crate://crates.io/phf_generator/0.10.0 \
> -    crate://crates.io/phf_shared/0.10.0 \
> -    crate://crates.io/polyval/0.5.3 \
> -    crate://crates.io/ppv-lite86/0.2.17 \
> -    crate://crates.io/proc-macro-crate/1.1.0 \
> -    crate://crates.io/proc-macro2/0.4.30 \
> -    crate://crates.io/proc-macro2/1.0.64 \
> -    crate://crates.io/quote/0.6.13 \
> -    crate://crates.io/quote/1.0.29 \
> -    crate://crates.io/rand/0.8.5 \
> -    crate://crates.io/rand_chacha/0.3.1 \
> -    crate://crates.io/rand_core/0.6.4 \
> -    crate://crates.io/regex/1.5.6 \
> -    crate://crates.io/regex-syntax/0.6.29 \
> -    crate://crates.io/rusticata-macros/4.1.0 \
> -    crate://crates.io/rustversion/1.0.13 \
> -    crate://crates.io/sawp/0.12.1 \
> -    crate://crates.io/sawp-flags/0.12.1 \
> -    crate://crates.io/sawp-flags-derive/0.12.1 \
> -    crate://crates.io/sawp-modbus/0.12.1 \
> -    crate://crates.io/serde/1.0.171 \
> -    crate://crates.io/sha1/0.10.5 \
> -    crate://crates.io/sha2/0.10.7 \
> -    crate://crates.io/siphasher/0.3.10 \
> -    crate://crates.io/snmp-parser/0.9.0 \
> -    crate://crates.io/subtle/2.4.1 \
> -    crate://crates.io/syn/0.15.44 \
> -    crate://crates.io/syn/1.0.109 \
> -    crate://crates.io/syn/2.0.25 \
> -    crate://crates.io/synstructure/0.12.6 \
> -    crate://crates.io/test-case/1.1.0 \
> -    crate://crates.io/thiserror/1.0.43 \
> -    crate://crates.io/thiserror-impl/1.0.43 \
> -    crate://crates.io/time/0.3.13 \
> -    crate://crates.io/time-macros/0.2.4 \
> -    crate://crates.io/tls-parser/0.11.0 \
> -    crate://crates.io/toml/0.5.11 \
> -    crate://crates.io/typenum/1.16.0 \
> -    crate://crates.io/unicode-ident/1.0.10 \
> -    crate://crates.io/unicode-xid/0.1.0 \
> -    crate://crates.io/unicode-xid/0.2.4 \
> -    crate://crates.io/universal-hash/0.4.1 \
> -    crate://crates.io/uuid/0.8.2 \
> -    crate://crates.io/version_check/0.9.4 \
> -    crate://crates.io/wasi/0.11.0+wasi-snapshot-preview1 \
> -    crate://crates.io/widestring/0.4.3 \
> -    crate://crates.io/x509-parser/0.15.0 \
> -"
> +SRC_URI += "crate://crates.io/adler/1.0.2 \
> +           crate://crates.io/aead/0.4.3 \
> +           crate://crates.io/aes/0.7.5 \
> +           crate://crates.io/aes-gcm/0.9.4 \
> +           crate://crates.io/aho-corasick/0.7.20 \
> +           crate://crates.io/alloc-no-stdlib/2.0.4 \
> +           crate://crates.io/alloc-stdlib/0.2.2 \
> +           crate://crates.io/asn1-rs/0.5.2 \
> +           crate://crates.io/asn1-rs-derive/0.4.0 \
> +           crate://crates.io/asn1-rs-impl/0.1.0 \
> +           crate://crates.io/autocfg/1.1.0 \
> +           crate://crates.io/base64/0.13.1 \
> +           crate://crates.io/bendy/0.3.3 \
> +           crate://crates.io/bitflags/1.2.1 \
> +           crate://crates.io/block-buffer/0.10.4 \
> +           crate://crates.io/brotli/8.0.1 \
> +           crate://crates.io/brotli-decompressor/5.0.0 \
> +           crate://crates.io/build_const/0.2.2 \
> +           crate://crates.io/byteorder/1.4.3 \
> +           crate://crates.io/cfg-if/1.0.0 \
> +           crate://crates.io/cipher/0.3.0 \
> +           crate://crates.io/cpufeatures/0.2.11 \
> +           crate://crates.io/crc/1.8.1 \
> +           crate://crates.io/crc32fast/1.3.2 \
> +           crate://crates.io/crypto-common/0.1.6 \
> +           crate://crates.io/ctr/0.8.0 \
> +           crate://crates.io/data-encoding/2.4.0 \
> +           crate://crates.io/der-oid-macro/0.5.0 \
> +           crate://crates.io/der-parser/6.0.1 \
> +           crate://crates.io/der-parser/8.2.0 \
> +           crate://crates.io/digest/0.10.7 \
> +           crate://crates.io/displaydoc/0.2.4 \
> +           crate://crates.io/enum_primitive/0.1.1 \
> +           crate://crates.io/failure/0.1.8 \
> +           crate://crates.io/failure_derive/0.1.8 \
> +           crate://crates.io/flate2/1.0.28 \
> +           crate://crates.io/generic-array/0.14.7 \
> +           crate://crates.io/getrandom/0.2.11 \
> +           crate://crates.io/ghash/0.4.4 \
> +           crate://crates.io/hex/0.4.3 \
> +           crate://crates.io/hkdf/0.12.3 \
> +           crate://crates.io/hmac/0.12.1 \
> +           crate://crates.io/ipsec-parser/0.7.0 \
> +           crate://crates.io/itoa/1.0.9 \
> +           crate://crates.io/kerberos-parser/0.7.1 \
> +           crate://crates.io/lazy_static/1.4.0 \
> +           crate://crates.io/libc/0.2.150 \
> +           crate://crates.io/lzma-rs/0.2.0 \
> +           crate://crates.io/md-5/0.10.6 \
> +           crate://crates.io/memchr/2.4.1 \
> +           crate://crates.io/minimal-lexical/0.2.1 \
> +           crate://crates.io/miniz_oxide/0.7.1 \
> +           crate://crates.io/nom/7.1.3 \
> +           crate://crates.io/nom-derive/0.10.1 \
> +           crate://crates.io/nom-derive-impl/0.10.1 \
> +           crate://crates.io/ntp-parser/0.6.0 \
> +           crate://crates.io/num/0.2.1 \
> +           crate://crates.io/num-bigint/0.2.6 \
> +           crate://crates.io/num-bigint/0.4.4 \
> +           crate://crates.io/num-complex/0.2.4 \
> +           crate://crates.io/num-derive/0.4.2 \
> +           crate://crates.io/num-integer/0.1.45 \
> +           crate://crates.io/num-iter/0.1.43 \
> +           crate://crates.io/num-rational/0.2.4 \
> +           crate://crates.io/num-traits/0.1.43 \
> +           crate://crates.io/num-traits/0.2.17 \
> +           crate://crates.io/num_enum/0.5.11 \
> +           crate://crates.io/num_enum_derive/0.5.11 \
> +           crate://crates.io/num_threads/0.1.6 \
> +           crate://crates.io/oid-registry/0.6.1 \
> +           crate://crates.io/opaque-debug/0.3.0 \
> +           crate://crates.io/phf/0.10.1 \
> +           crate://crates.io/phf_codegen/0.10.0 \
> +           crate://crates.io/phf_generator/0.10.0 \
> +           crate://crates.io/phf_shared/0.10.0 \
> +           crate://crates.io/polyval/0.5.3 \
> +           crate://crates.io/ppv-lite86/0.2.17 \
> +           crate://crates.io/proc-macro-crate/1.1.0 \
> +           crate://crates.io/proc-macro2/1.0.69 \
> +           crate://crates.io/quote/1.0.33 \
> +           crate://crates.io/rand/0.8.5 \
> +           crate://crates.io/rand_chacha/0.3.1 \
> +           crate://crates.io/rand_core/0.6.4 \
> +           crate://crates.io/regex/1.5.6 \
> +           crate://crates.io/regex-syntax/0.6.29 \
> +           crate://crates.io/rusticata-macros/4.1.0 \
> +           crate://crates.io/rustversion/1.0.14 \
> +           crate://crates.io/sawp/0.12.1 \
> +           crate://crates.io/sawp-flags/0.12.1 \
> +           crate://crates.io/sawp-flags-derive/0.12.1 \
> +           crate://crates.io/sawp-modbus/0.12.1 \
> +           crate://crates.io/serde/1.0.192 \
> +           crate://crates.io/serde_derive/1.0.192 \
> +           crate://crates.io/sha1/0.10.6 \
> +           crate://crates.io/sha2/0.10.8 \
> +           crate://crates.io/siphasher/0.3.11 \
> +           crate://crates.io/snmp-parser/0.9.0 \
> +           crate://crates.io/subtle/2.4.1 \
> +           crate://crates.io/syn/1.0.109 \
> +           crate://crates.io/syn/2.0.39 \
> +           crate://crates.io/synstructure/0.12.6 \
> +           crate://crates.io/test-case/1.1.0 \
> +           crate://crates.io/thiserror/1.0.50 \
> +           crate://crates.io/thiserror-impl/1.0.50 \
> +           crate://crates.io/time/0.3.13 \
> +           crate://crates.io/time-macros/0.2.4 \
> +           crate://crates.io/tls-parser/0.11.0 \
> +           crate://crates.io/toml/0.5.11 \
> +           crate://crates.io/typenum/1.17.0 \
> +           crate://crates.io/unicode-ident/1.0.12 \
> +           crate://crates.io/unicode-xid/0.2.4 \
> +           crate://crates.io/universal-hash/0.4.1 \
> +           crate://crates.io/uuid/0.8.2 \
> +           crate://crates.io/version_check/0.9.4 \
> +           crate://crates.io/wasi/0.11.0+wasi-snapshot-preview1 \
> +           crate://crates.io/widestring/0.4.3 \
> +           crate://crates.io/x509-parser/0.15.1 \
> +           crate://crates.io/ansi_term/0.12.1 \
> +           crate://crates.io/atty/0.2.14 \
> +           crate://crates.io/autocfg/0.1.8 \
> +           crate://crates.io/autocfg/1.1.0 \
> +           crate://crates.io/bitflags/1.3.2 \
> +           crate://crates.io/bstr/0.2.17 \
> +           crate://crates.io/bumpalo/3.11.1 \
> +           crate://crates.io/cast/0.2.7 \
> +           crate://crates.io/cast/0.3.0 \
> +           crate://crates.io/cfg-if/1.0.0 \
> +           crate://crates.io/clap/2.34.0 \
> +           crate://crates.io/cloudabi/0.0.3 \
> +           crate://crates.io/criterion/0.3.2 \
> +           crate://crates.io/criterion-plot/0.4.5 \
> +           crate://crates.io/crossbeam-channel/0.5.6 \
> +           crate://crates.io/crossbeam-deque/0.8.2 \
> +           crate://crates.io/crossbeam-epoch/0.9.11 \
> +           crate://crates.io/crossbeam-utils/0.8.12 \
> +           crate://crates.io/csv/1.1.6 \
> +           crate://crates.io/csv-core/0.1.10 \
> +           crate://crates.io/either/1.8.0 \
> +           crate://crates.io/fuchsia-cprng/0.1.1 \
> +           crate://crates.io/heck/0.3.3 \
> +           crate://crates.io/hermit-abi/0.1.19 \
> +           crate://crates.io/itertools/0.9.0 \
> +           crate://crates.io/itertools/0.10.5 \
> +           crate://crates.io/itoa/0.4.8 \
> +           crate://crates.io/itoa/1.0.4 \
> +           crate://crates.io/js-sys/0.3.60 \
> +           crate://crates.io/lazy_static/1.4.0 \
> +           crate://crates.io/libc/0.2.135 \
> +           crate://crates.io/log/0.4.17 \
> +           crate://crates.io/memchr/2.5.0 \
> +           crate://crates.io/memoffset/0.6.5 \
> +           crate://crates.io/num-traits/0.2.15 \
> +           crate://crates.io/num_cpus/1.13.1 \
> +           crate://crates.io/once_cell/1.15.0 \
> +           crate://crates.io/oorandom/11.1.3 \
> +           crate://crates.io/plotters/0.2.15 \
> +           crate://crates.io/proc-macro-error/1.0.4 \
> +           crate://crates.io/proc-macro-error-attr/1.0.4 \
> +           crate://crates.io/proc-macro2/1.0.47 \
> +           crate://crates.io/quote/1.0.21 \
> +           crate://crates.io/rand/0.6.5 \
> +           crate://crates.io/rand_chacha/0.1.1 \
> +           crate://crates.io/rand_core/0.3.1 \
> +           crate://crates.io/rand_core/0.4.2 \
> +           crate://crates.io/rand_hc/0.1.0 \
> +           crate://crates.io/rand_isaac/0.1.1 \
> +           crate://crates.io/rand_jitter/0.1.4 \
> +           crate://crates.io/rand_os/0.1.3 \
> +           crate://crates.io/rand_pcg/0.1.2 \
> +           crate://crates.io/rand_xorshift/0.1.1 \
> +           crate://crates.io/rayon/1.5.3 \
> +           crate://crates.io/rayon-core/1.9.3 \
> +           crate://crates.io/rdrand/0.4.0 \
> +           crate://crates.io/regex/1.6.0 \
> +           crate://crates.io/regex-automata/0.1.10 \
> +           crate://crates.io/regex-syntax/0.6.27 \
> +           crate://crates.io/rustc_version/0.4.0 \
> +           crate://crates.io/ryu/1.0.11 \
> +           crate://crates.io/same-file/1.0.6 \
> +           crate://crates.io/scopeguard/1.1.0 \
> +           crate://crates.io/semver/1.0.14 \
> +           crate://crates.io/serde/1.0.146 \
> +           crate://crates.io/serde_derive/1.0.146 \
> +           crate://crates.io/serde_json/1.0.87 \
> +           crate://crates.io/strsim/0.8.0 \
> +           crate://crates.io/structopt/0.3.26 \
> +           crate://crates.io/structopt-derive/0.4.18 \
> +           crate://crates.io/syn/1.0.103 \
> +           crate://crates.io/textwrap/0.11.0 \
> +           crate://crates.io/tinytemplate/1.2.1 \
> +           crate://crates.io/unicode-ident/1.0.5 \
> +           crate://crates.io/unicode-segmentation/1.10.0 \
> +           crate://crates.io/unicode-width/0.1.10 \
> +           crate://crates.io/vec_map/0.8.2 \
> +           crate://crates.io/version_check/0.9.4 \
> +           crate://crates.io/walkdir/2.3.2 \
> +           crate://crates.io/wasm-bindgen/0.2.83 \
> +           crate://crates.io/wasm-bindgen-backend/0.2.83 \
> +           crate://crates.io/wasm-bindgen-macro/0.2.83 \
> +           crate://crates.io/wasm-bindgen-macro-support/0.2.83 \
> +           crate://crates.io/wasm-bindgen-shared/0.2.83 \
> +           crate://crates.io/web-sys/0.3.60 \
> +           crate://crates.io/winapi/0.3.9 \
> +           crate://crates.io/winapi-i686-pc-windows-gnu/0.4.0 \
> +           crate://crates.io/winapi-util/0.1.5 \
> +           crate://crates.io/winapi-x86_64-pc-windows-gnu/0.4.0 \
> +           crate://crates.io/backtrace/0.3.46 \
> +           crate://crates.io/backtrace-sys/0.1.37 \
> +           crate://crates.io/cc/1.0.52 \
> +           crate://crates.io/cfg-if/0.1.10 \
> +           crate://crates.io/failure_derive/0.1.7 \
> +           crate://crates.io/libc/0.2.69 \
> +           crate://crates.io/proc-macro2/1.0.12 \
> +           crate://crates.io/quote/1.0.4 \
> +           crate://crates.io/rustc-demangle/0.1.16 \
> +           crate://crates.io/syn/1.0.18 \
> +           crate://crates.io/synstructure/0.12.3 \
> +           crate://crates.io/unicode-xid/0.2.0 \
> +           crate://crates.io/autocfg/1.1.0 \
> +           crate://crates.io/hashbrown/0.12.3 \
> +           crate://crates.io/indexmap/1.9.2 \
> +           crate://crates.io/itoa/1.0.5 \
> +           crate://crates.io/proc-macro2/1.0.50 \
> +           crate://crates.io/quote/1.0.23 \
> +           crate://crates.io/ryu/1.0.12 \
> +           crate://crates.io/serde/1.0.152 \
> +           crate://crates.io/serde_derive/1.0.152 \
> +           crate://crates.io/serde_json/1.0.91 \
> +           crate://crates.io/syn/1.0.107 \
> +           crate://crates.io/unicode-ident/1.0.6 \
> +           crate://crates.io/autocfg/1.0.1 \
> +           crate://crates.io/bit-set/0.5.2 \
> +           crate://crates.io/bit-vec/0.6.3 \
> +           crate://crates.io/bitflags/1.3.2 \
> +           crate://crates.io/byteorder/1.4.3 \
> +           crate://crates.io/cfg-if/1.0.0 \
> +           crate://crates.io/doc-comment/0.3.3 \
> +           crate://crates.io/fnv/1.0.7 \
> +           crate://crates.io/getrandom/0.2.3 \
> +           crate://crates.io/lazy_static/1.4.0 \
> +           crate://crates.io/libc/0.2.106 \
> +           crate://crates.io/memchr/2.4.1 \
> +           crate://crates.io/minimal-lexical/0.2.1 \
> +           crate://crates.io/num-traits/0.2.14 \
> +           crate://crates.io/ppv-lite86/0.2.15 \
> +           crate://crates.io/proptest/1.0.0 \
> +           crate://crates.io/quick-error/1.2.3 \
> +           crate://crates.io/quick-error/2.0.1 \
> +           crate://crates.io/rand/0.8.4 \
> +           crate://crates.io/rand_chacha/0.3.1 \
> +           crate://crates.io/rand_core/0.6.3 \
> +           crate://crates.io/rand_hc/0.3.1 \
> +           crate://crates.io/rand_xorshift/0.3.0 \
> +           crate://crates.io/redox_syscall/0.2.10 \
> +           crate://crates.io/regex-syntax/0.6.25 \
> +           crate://crates.io/remove_dir_all/0.5.3 \
> +           crate://crates.io/rusty-fork/0.3.0 \
> +           crate://crates.io/tempfile/3.2.0 \
> +           crate://crates.io/wait-timeout/0.2.0 \
> +           crate://crates.io/wasi/0.10.2+wasi-snapshot-preview1 \
> +           crate://crates.io/winapi/0.3.9 \
> +           crate://crates.io/winapi-i686-pc-windows-gnu/0.4.0 \
> +           crate://crates.io/winapi-x86_64-pc-windows-gnu/0.4.0 \
> +           crate://crates.io/alloc-no-stdlib/2.0.4 \
> +           crate://crates.io/alloc-stdlib/0.2.2 \
> +           crate://crates.io/ansi_term/0.11.0 \
> +           crate://crates.io/basic-toml/0.1.2 \
> +           crate://crates.io/ctor/0.1.26 \
> +           crate://crates.io/difference/2.0.0 \
> +           crate://crates.io/glob/0.3.1 \
> +           crate://crates.io/itoa/1.0.6 \
> +           crate://crates.io/libc/0.2.142 \
> +           crate://crates.io/once_cell/1.17.1 \
> +           crate://crates.io/output_vt100/0.1.3 \
> +           crate://crates.io/pretty_assertions/0.6.1 \
> +           crate://crates.io/proc-macro2/1.0.56 \
> +           crate://crates.io/quote/1.0.26 \
> +           crate://crates.io/rustversion/1.0.12 \
> +           crate://crates.io/ryu/1.0.13 \
> +           crate://crates.io/serde/1.0.160 \
> +           crate://crates.io/serde_derive/1.0.160 \
> +           crate://crates.io/serde_json/1.0.96 \
> +           crate://crates.io/static_assertions/1.1.0 \
> +           crate://crates.io/syn/1.0.109 \
> +           crate://crates.io/syn/2.0.15 \
> +           crate://crates.io/termcolor/1.2.0 \
> +           crate://crates.io/thiserror/1.0.40 \
> +           crate://crates.io/thiserror-impl/1.0.40 \
> +           crate://crates.io/trybuild/1.0.80 \
> +           crate://crates.io/unicode-ident/1.0.8 \
> +           crate://crates.io/winapi/0.3.9 \
> +           crate://crates.io/winapi-i686-pc-windows-gnu/0.4.0 \
> +           crate://crates.io/winapi-util/0.1.5 \
> +           crate://crates.io/winapi-x86_64-pc-windows-gnu/0.4.0 \
> +           crate://crates.io/asn1-rs/0.5.1 \
> +           crate://crates.io/asn1-rs-derive/0.4.0 \
> +           crate://crates.io/asn1-rs-impl/0.1.0 \
> +           crate://crates.io/atty/0.2.14 \
> +           crate://crates.io/autocfg/1.1.0 \
> +           crate://crates.io/base64/0.13.1 \
> +           crate://crates.io/basic-toml/0.1.2 \
> +           crate://crates.io/bitvec/1.0.1 \
> +           crate://crates.io/colored/2.0.0 \
> +           crate://crates.io/cookie-factory/0.3.2 \
> +           crate://crates.io/displaydoc/0.2.3 \
> +           crate://crates.io/funty/2.0.0 \
> +           crate://crates.io/glob/0.3.1 \
> +           crate://crates.io/hermit-abi/0.1.19 \
> +           crate://crates.io/hex-literal/0.3.4 \
> +           crate://crates.io/itoa/1.0.6 \
> +           crate://crates.io/lazy_static/1.4.0 \
> +           crate://crates.io/libc/0.2.139 \
> +           crate://crates.io/memchr/2.5.0 \
> +           crate://crates.io/minimal-lexical/0.2.1 \
> +           crate://crates.io/nom/7.1.3 \
> +           crate://crates.io/num-bigint/0.4.3 \
> +           crate://crates.io/num-integer/0.1.45 \
> +           crate://crates.io/num-traits/0.2.15 \
> +           crate://crates.io/oid-registry/0.6.1 \
> +           crate://crates.io/once_cell/1.17.1 \
> +           crate://crates.io/pem/1.1.1 \
> +           crate://crates.io/proc-macro2/1.0.51 \
> +           crate://crates.io/quote/1.0.23 \
> +           crate://crates.io/radium/0.7.0 \
> +           crate://crates.io/rusticata-macros/4.1.0 \
> +           crate://crates.io/ryu/1.0.13 \
> +           crate://crates.io/serde/1.0.152 \
> +           crate://crates.io/serde_derive/1.0.152 \
> +           crate://crates.io/serde_json/1.0.94 \
> +           crate://crates.io/syn/1.0.109 \
> +           crate://crates.io/synstructure/0.12.6 \
> +           crate://crates.io/tap/1.0.1 \
> +           crate://crates.io/termcolor/1.2.0 \
> +           crate://crates.io/thiserror/1.0.39 \
> +           crate://crates.io/thiserror-impl/1.0.39 \
> +           crate://crates.io/time/0.3.20 \
> +           crate://crates.io/time-core/0.1.0 \
> +           crate://crates.io/time-macros/0.2.8 \
> +           crate://crates.io/trybuild/1.0.79 \
> +           crate://crates.io/unicode-ident/1.0.8 \
> +           crate://crates.io/unicode-xid/0.2.4 \
> +           crate://crates.io/winapi/0.3.9 \
> +           crate://crates.io/winapi-i686-pc-windows-gnu/0.4.0 \
> +           crate://crates.io/winapi-util/0.1.5 \
> +           crate://crates.io/winapi-x86_64-pc-windows-gnu/0.4.0 \
> +           crate://crates.io/wyz/0.5.1 \
> +           crate://crates.io/alloc-no-stdlib/2.0.4 \
> +           crate://crates.io/alloc-stdlib/0.2.2 \
> +           crate://crates.io/block-buffer/0.10.4 \
> +           crate://crates.io/brotli-decompressor/5.0.0 \
> +           crate://crates.io/cfg-if/1.0.0 \
> +           crate://crates.io/cpufeatures/0.2.17 \
> +           crate://crates.io/crypto-common/0.1.6 \
> +           crate://crates.io/digest/0.10.7 \
> +           crate://crates.io/generic-array/0.14.7 \
> +           crate://crates.io/libc/0.2.172 \
> +           crate://crates.io/sha2/0.10.9 \
> +           crate://crates.io/typenum/1.18.0 \
> +           crate://crates.io/version_check/0.9.5 \
> +           crate://crates.io/atty/0.2.14 \
> +           crate://crates.io/autocfg/1.0.1 \
> +           crate://crates.io/bitflags/1.2.1 \
> +           crate://crates.io/bstr/0.2.16 \
> +           crate://crates.io/bumpalo/3.7.0 \
> +           crate://crates.io/cast/0.2.7 \
> +           crate://crates.io/cfg-if/1.0.0 \
> +           crate://crates.io/clap/2.33.3 \
> +           crate://crates.io/criterion/0.3.4 \
> +           crate://crates.io/criterion-plot/0.4.4 \
> +           crate://crates.io/crossbeam-channel/0.5.1 \
> +           crate://crates.io/crossbeam-deque/0.8.1 \
> +           crate://crates.io/crossbeam-epoch/0.9.5 \
> +           crate://crates.io/crossbeam-utils/0.8.5 \
> +           crate://crates.io/csv/1.1.6 \
> +           crate://crates.io/csv-core/0.1.10 \
> +           crate://crates.io/either/1.6.1 \
> +           crate://crates.io/getrandom/0.2.3 \
> +           crate://crates.io/half/1.7.1 \
> +           crate://crates.io/hermit-abi/0.1.19 \
> +           crate://crates.io/itertools/0.10.1 \
> +           crate://crates.io/itoa/0.4.7 \
> +           crate://crates.io/js-sys/0.3.52 \
> +           crate://crates.io/lazy_static/1.4.0 \
> +           crate://crates.io/libc/0.2.99 \
> +           crate://crates.io/log/0.4.14 \
> +           crate://crates.io/memchr/2.4.0 \
> +           crate://crates.io/memoffset/0.6.4 \
> +           crate://crates.io/num-traits/0.2.14 \
> +           crate://crates.io/num_cpus/1.13.0 \
> +           crate://crates.io/oorandom/11.1.3 \
> +           crate://crates.io/phf_shared/0.10.0 \
> +           crate://crates.io/plotters/0.3.1 \
> +           crate://crates.io/plotters-backend/0.3.2 \
> +           crate://crates.io/plotters-svg/0.3.1 \
> +           crate://crates.io/ppv-lite86/0.2.10 \
> +           crate://crates.io/proc-macro2/1.0.28 \
> +           crate://crates.io/quote/1.0.9 \
> +           crate://crates.io/rand/0.8.4 \
> +           crate://crates.io/rand_chacha/0.3.1 \
> +           crate://crates.io/rand_core/0.6.3 \
> +           crate://crates.io/rand_hc/0.3.1 \
> +           crate://crates.io/rayon/1.5.1 \
> +           crate://crates.io/rayon-core/1.9.1 \
> +           crate://crates.io/regex/1.5.4 \
> +           crate://crates.io/regex-automata/0.1.10 \
> +           crate://crates.io/regex-syntax/0.6.25 \
> +           crate://crates.io/rustc_version/0.4.0 \
> +           crate://crates.io/ryu/1.0.5 \
> +           crate://crates.io/same-file/1.0.6 \
> +           crate://crates.io/scopeguard/1.1.0 \
> +           crate://crates.io/semver/1.0.4 \
> +           crate://crates.io/serde/1.0.127 \
> +           crate://crates.io/serde_cbor/0.11.1 \
> +           crate://crates.io/serde_derive/1.0.127 \
> +           crate://crates.io/serde_json/1.0.66 \
> +           crate://crates.io/siphasher/0.3.6 \
> +           crate://crates.io/syn/1.0.74 \
> +           crate://crates.io/textwrap/0.11.0 \
> +           crate://crates.io/tinytemplate/1.2.1 \
> +           crate://crates.io/unicode-width/0.1.8 \
> +           crate://crates.io/unicode-xid/0.2.2 \
> +           crate://crates.io/walkdir/2.3.2 \
> +           crate://crates.io/wasi/0.10.2+wasi-snapshot-preview1 \
> +           crate://crates.io/wasm-bindgen/0.2.75 \
> +           crate://crates.io/wasm-bindgen-backend/0.2.75 \
> +           crate://crates.io/wasm-bindgen-macro/0.2.75 \
> +           crate://crates.io/wasm-bindgen-macro-support/0.2.75 \
> +           crate://crates.io/wasm-bindgen-shared/0.2.75 \
> +           crate://crates.io/web-sys/0.3.52 \
> +           crate://crates.io/winapi/0.3.9 \
> +           crate://crates.io/winapi-i686-pc-windows-gnu/0.4.0 \
> +           crate://crates.io/winapi-util/0.1.5 \
> +           crate://crates.io/winapi-x86_64-pc-windows-gnu/0.4.0 \
> +           crate://crates.io/alloc-no-stdlib/2.0.4 \
> +           crate://crates.io/asn1-rs/0.5.2 \
> +           crate://crates.io/asn1-rs-derive/0.4.0 \
> +           crate://crates.io/asn1-rs-impl/0.1.0 \
> +           crate://crates.io/autocfg/1.1.0 \
> +           crate://crates.io/bumpalo/3.13.0 \
> +           crate://crates.io/cc/1.0.81 \
> +           crate://crates.io/cfg-if/1.0.0 \
> +           crate://crates.io/data-encoding/2.4.0 \
> +           crate://crates.io/der-parser/8.2.0 \
> +           crate://crates.io/deranged/0.3.7 \
> +           crate://crates.io/displaydoc/0.2.4 \
> +           crate://crates.io/itoa/1.0.9 \
> +           crate://crates.io/js-sys/0.3.64 \
> +           crate://crates.io/lazy_static/1.4.0 \
> +           crate://crates.io/libc/0.2.147 \
> +           crate://crates.io/log/0.4.19 \
> +           crate://crates.io/memchr/2.5.0 \
> +           crate://crates.io/minimal-lexical/0.2.1 \
> +           crate://crates.io/nom/7.1.3 \
> +           crate://crates.io/num-bigint/0.4.3 \
> +           crate://crates.io/num-integer/0.1.45 \
> +           crate://crates.io/num-traits/0.2.16 \
> +           crate://crates.io/oid-registry/0.6.1 \
> +           crate://crates.io/once_cell/1.18.0 \
> +           crate://crates.io/proc-macro2/1.0.66 \
> +           crate://crates.io/quote/1.0.32 \
> +           crate://crates.io/ring/0.16.20 \
> +           crate://crates.io/rusticata-macros/4.1.0 \
> +           crate://crates.io/serde/1.0.180 \
> +           crate://crates.io/spin/0.5.2 \
> +           crate://crates.io/syn/1.0.109 \
> +           crate://crates.io/syn/2.0.28 \
> +           crate://crates.io/synstructure/0.12.6 \
> +           crate://crates.io/thiserror/1.0.44 \
> +           crate://crates.io/thiserror-impl/1.0.44 \
> +           crate://crates.io/time/0.3.25 \
> +           crate://crates.io/time-core/0.1.1 \
> +           crate://crates.io/time-macros/0.2.11 \
> +           crate://crates.io/unicode-ident/1.0.11 \
> +           crate://crates.io/unicode-xid/0.2.4 \
> +           crate://crates.io/untrusted/0.7.1 \
> +           crate://crates.io/wasm-bindgen/0.2.87 \
> +           crate://crates.io/wasm-bindgen-backend/0.2.87 \
> +           crate://crates.io/wasm-bindgen-macro/0.2.87 \
> +           crate://crates.io/wasm-bindgen-macro-support/0.2.87 \
> +           crate://crates.io/wasm-bindgen-shared/0.2.87 \
> +           crate://crates.io/web-sys/0.3.64 \
> +           crate://crates.io/winapi/0.3.9 \
> +           crate://crates.io/winapi-i686-pc-windows-gnu/0.4.0 \
> +           crate://crates.io/winapi-x86_64-pc-windows-gnu/0.4.0 \
> +           crate://crates.io/aho-corasick/0.7.18 \
> +           crate://crates.io/cfg-if/1.0.0 \
> +           crate://crates.io/getrandom/0.2.6 \
> +           crate://crates.io/lazy_static/1.4.0 \
> +           crate://crates.io/libc/0.2.125 \
> +           crate://crates.io/memchr/2.5.0 \
> +           crate://crates.io/quickcheck/1.0.3 \
> +           crate://crates.io/rand/0.8.5 \
> +           crate://crates.io/rand_core/0.6.3 \
> +           crate://crates.io/regex-syntax/0.6.26 \
> +           crate://crates.io/wasi/0.10.2+wasi-snapshot-preview1 \
> +           crate://crates.io/addr2line/0.14.0 \
> +           crate://crates.io/adler/0.2.3 \
> +           crate://crates.io/aho-corasick/0.7.15 \
> +           crate://crates.io/autocfg/1.0.1 \
> +           crate://crates.io/backtrace/0.3.54 \
> +           crate://crates.io/cfg-if/1.0.0 \
> +           crate://crates.io/failure/0.1.8 \
> +           crate://crates.io/failure_derive/0.1.8 \
> +           crate://crates.io/gimli/0.23.0 \
> +           crate://crates.io/lazy_static/1.4.0 \
> +           crate://crates.io/libc/0.2.80 \
> +           crate://crates.io/memchr/2.3.4 \
> +           crate://crates.io/miniz_oxide/0.4.3 \
> +           crate://crates.io/object/0.22.0 \
> +           crate://crates.io/proc-macro2/1.0.24 \
> +           crate://crates.io/quote/1.0.7 \
> +           crate://crates.io/regex/1.4.2 \
> +           crate://crates.io/regex-syntax/0.6.21 \
> +           crate://crates.io/rustc-demangle/0.1.18 \
> +           crate://crates.io/serde/1.0.117 \
> +           crate://crates.io/serde_bytes/0.11.5 \
> +           crate://crates.io/serde_derive/1.0.117 \
> +           crate://crates.io/syn/1.0.48 \
> +           crate://crates.io/synstructure/0.12.4 \
> +           crate://crates.io/thread_local/1.0.1 \
> +           crate://crates.io/unicode-xid/0.2.1 \
> +           crate://crates.io/adler/1.0.2 \
> +           crate://crates.io/cc/1.0.79 \
> +           crate://crates.io/cfg-if/1.0.0 \
> +           crate://crates.io/cloudflare-zlib-sys/0.3.0 \
> +           crate://crates.io/cmake/0.1.50 \
> +           crate://crates.io/crc32fast/1.3.2 \
> +           crate://crates.io/getrandom/0.2.9 \
> +           crate://crates.io/libc/0.2.144 \
> +           crate://crates.io/libz-ng-sys/1.1.10 \
> +           crate://crates.io/libz-sys/1.1.10 \
> +           crate://crates.io/miniz_oxide/0.7.1 \
> +           crate://crates.io/pkg-config/0.3.27 \
> +           crate://crates.io/ppv-lite86/0.2.17 \
> +           crate://crates.io/quickcheck/1.0.3 \
> +           crate://crates.io/rand/0.8.5 \
> +           crate://crates.io/rand_chacha/0.3.1 \
> +           crate://crates.io/rand_core/0.6.4 \
> +           crate://crates.io/vcpkg/0.2.15 \
> +           crate://crates.io/wasi/0.11.0+wasi-snapshot-preview1 \
> +           "
>
>  SRC_URI[adler-1.0.2.sha256sum] = "f26201604c87b1e01bd3d98f8d5d9a8fcbb815e8cedb41ffccbeb4bf593a35fe"
>  SRC_URI[aead-0.4.3.sha256sum] = "0b613b8e1e3cf911a086f53f03bf286f52fd7a7258e4fa606f0ef220d39d8877"
> @@ -139,13 +558,13 @@ SRC_URI[base64-0.13.1.sha256sum] = "9e1b586273c5702936fe7b7d6896644d8be71e6314cf
>  SRC_URI[bendy-0.3.3.sha256sum] = "8133e404c8bec821e531f347dab1247bf64f60882826e7228f8ffeb33a35a658"
>  SRC_URI[bitflags-1.2.1.sha256sum] = "cf1de2fe8c75bc145a2f577add951f8134889b4795d47466a54a5c846d691693"
>  SRC_URI[block-buffer-0.10.4.sha256sum] = "3078c7629b62d3f0439517fa394996acacc5cbc91c5a20d8c658e77abd503a71"
> -SRC_URI[brotli-3.3.4.sha256sum] = "a1a0b1dbcc8ae29329621f8d4f0d835787c1c38bb1401979b49d13b0b305ff68"
> -SRC_URI[brotli-decompressor-2.3.4.sha256sum] = "4b6561fd3f895a11e8f72af2cb7d22e08366bebc2b6b57f7744c4bda27034744"
> +SRC_URI[brotli-8.0.1.sha256sum] = "9991eea70ea4f293524138648e41ee89b0b2b12ddef3b255effa43c8056e0e0d"
> +SRC_URI[brotli-decompressor-5.0.0.sha256sum] = "874bb8112abecc98cbd6d81ea4fa7e94fb9449648c93cc89aa40c81c24d7de03"
>  SRC_URI[build_const-0.2.2.sha256sum] = "b4ae4235e6dac0694637c763029ecea1a2ec9e4e06ec2729bd21ba4d9c863eb7"
>  SRC_URI[byteorder-1.4.3.sha256sum] = "14c189c53d098945499cdfa7ecc63567cf3886b3332b312a5b4585d8d3a6a610"
>  SRC_URI[cfg-if-1.0.0.sha256sum] = "baf1de4339761588bc0619e3cbc0120ee582ebb74b53b4efbf79117bd2da40fd"
>  SRC_URI[cipher-0.3.0.sha256sum] = "7ee52072ec15386f770805afd189a01c8841be8696bed250fa2f13c4c0d6dfb7"
> -SRC_URI[cpufeatures-0.2.9.sha256sum] = "a17b76ff3a4162b0b27f354a0c87015ddad39d35f9c0c36607a3bdd175dde1f1"
> +SRC_URI[cpufeatures-0.2.11.sha256sum] = "ce420fe07aecd3e67c5f910618fe65e94158f6dcc0adf44e00d69ce2bdfe0fd0"
>  SRC_URI[crc-1.8.1.sha256sum] = "d663548de7f5cca343f1e0a48d14dcfb0e9eb4e079ec58883b7251539fa10aeb"
>  SRC_URI[crc32fast-1.3.2.sha256sum] = "b540bd8bc810d3885c6ea91e2018302f68baba2129ab3e88f32389ee9370880d"
>  SRC_URI[crypto-common-0.1.6.sha256sum] = "1bfb12502f3fc46cca1bb51ac28df9d618d813cdc3d2f25b9fe775a34af26bb3"
> @@ -159,20 +578,20 @@ SRC_URI[displaydoc-0.2.4.sha256sum] = "487585f4d0c6655fe74905e2504d8ad6908e4db67
>  SRC_URI[enum_primitive-0.1.1.sha256sum] = "be4551092f4d519593039259a9ed8daedf0da12e5109c5280338073eaeb81180"
>  SRC_URI[failure-0.1.8.sha256sum] = "d32e9bd16cc02eae7db7ef620b392808b89f6a5e16bb3497d159c6b92a0f4f86"
>  SRC_URI[failure_derive-0.1.8.sha256sum] = "aa4da3c766cd7a0db8242e326e9e4e081edd567072893ed320008189715366a4"
> -SRC_URI[flate2-1.0.26.sha256sum] = "3b9429470923de8e8cbd4d2dc513535400b4b3fef0319fb5c4e1f520a7bef743"
> +SRC_URI[flate2-1.0.28.sha256sum] = "46303f565772937ffe1d394a4fac6f411c6013172fadde9dcdb1e147a086940e"
>  SRC_URI[generic-array-0.14.7.sha256sum] = "85649ca51fd72272d7821adaf274ad91c288277713d9c18820d8499a7ff69e9a"
> -SRC_URI[getrandom-0.2.10.sha256sum] = "be4136b2a15dd319360be1c07d9933517ccf0be8f16bf62a3bee4f0d618df427"
> +SRC_URI[getrandom-0.2.11.sha256sum] = "fe9006bed769170c11f845cf00c7c1e9092aeb3f268e007c3e760ac68008070f"
>  SRC_URI[ghash-0.4.4.sha256sum] = "1583cc1656d7839fd3732b80cf4f38850336cdb9b8ded1cd399ca62958de3c99"
>  SRC_URI[hex-0.4.3.sha256sum] = "7f24254aa9a54b5c858eaee2f5bccdb46aaf0e486a595ed5fd8f86ba55232a70"
>  SRC_URI[hkdf-0.12.3.sha256sum] = "791a029f6b9fc27657f6f188ec6e5e43f6911f6f878e0dc5501396e09809d437"
>  SRC_URI[hmac-0.12.1.sha256sum] = "6c49c37c09c17a53d937dfbb742eb3a961d65a994e6bcdcf37e7399d0cc8ab5e"
>  SRC_URI[ipsec-parser-0.7.0.sha256sum] = "2cf8413e5de78bcbc51880ff71f4b64105719abe6efb8b4b877d3c7dc494ddd1"
> -SRC_URI[itoa-1.0.8.sha256sum] = "62b02a5381cc465bd3041d84623d0fa3b66738b52b8e2fc3bab8ad63ab032f4a"
> +SRC_URI[itoa-1.0.9.sha256sum] = "af150ab688ff2122fcef229be89cb50dd66af9e01a4ff320cc137eecc9bacc38"
>  SRC_URI[kerberos-parser-0.7.1.sha256sum] = "c10e7cfd4759cbce37ea65e2f48caebd695c246196a38e97ba4f731da48996da"
>  SRC_URI[lazy_static-1.4.0.sha256sum] = "e2abad23fbc42b3700f2f279844dc832adb2b2eb069b2df918f455c4e18cc646"
> -SRC_URI[libc-0.2.147.sha256sum] = "b4668fb0ea861c1df094127ac5f1da3409a82116a4ba74fca2e58ef927159bb3"
> +SRC_URI[libc-0.2.150.sha256sum] = "89d92a4743f9a61002fae18374ed11e7973f530cb3a3255fb354818118b2203c"
>  SRC_URI[lzma-rs-0.2.0.sha256sum] = "aba8ecb0450dfabce4ad72085eed0a75dffe8f21f7ada05638564ea9db2d7fb1"
> -SRC_URI[md-5-0.10.5.sha256sum] = "6365506850d44bff6e2fbcb5176cf63650e48bd45ef2fe2665ae1570e0f4b9ca"
> +SRC_URI[md-5-0.10.6.sha256sum] = "d89e7ee0cfbedfc4da3340218492196241d89eefb6dab27de5df917a6d2e78cf"
>  SRC_URI[memchr-2.4.1.sha256sum] = "308cc39be01b73d0d18f82a0e7b2a3df85245f84af96fdddc5d202d27e47b86a"
>  SRC_URI[minimal-lexical-0.2.1.sha256sum] = "68354c5c6bd36d73ff3feceb05efa59b6acb7626617f4962be322a825e61f79a"
>  SRC_URI[miniz_oxide-0.7.1.sha256sum] = "e7810e0be55b428ada41041c41f32c9f1a42817901b4ccf45fa3d4b6561e74c7"
> @@ -182,14 +601,14 @@ SRC_URI[nom-derive-impl-0.10.1.sha256sum] = "cd0b9a93a84b0d3ec3e70e02d332dc33ac6
>  SRC_URI[ntp-parser-0.6.0.sha256sum] = "76084be9bf432d487336dd4e39b31ad93f94aecb14b81f08724f4a37b9abb7a5"
>  SRC_URI[num-0.2.1.sha256sum] = "b8536030f9fea7127f841b45bb6243b27255787fb4eb83958aa1ef9d2fdc0c36"
>  SRC_URI[num-bigint-0.2.6.sha256sum] = "090c7f9998ee0ff65aa5b723e4009f7b217707f1fb5ea551329cc4d6231fb304"
> -SRC_URI[num-bigint-0.4.3.sha256sum] = "f93ab6289c7b344a8a9f60f88d80aa20032336fe78da341afc91c8a2341fc75f"
> +SRC_URI[num-bigint-0.4.4.sha256sum] = "608e7659b5c3d7cba262d894801b9ec9d00de989e8a82bd4bef91d08da45cdc0"
>  SRC_URI[num-complex-0.2.4.sha256sum] = "b6b19411a9719e753aff12e5187b74d60d3dc449ec3f4dc21e3989c3f554bc95"
> -SRC_URI[num-derive-0.2.5.sha256sum] = "eafd0b45c5537c3ba526f79d3e75120036502bebacbb3f3220914067ce39dbf2"
> +SRC_URI[num-derive-0.4.2.sha256sum] = "ed3955f1a9c7c0c15e092f9c887db08b1fc683305fdf6eb6684f22555355e202"
>  SRC_URI[num-integer-0.1.45.sha256sum] = "225d3389fb3509a24c93f5c29eb6bde2586b98d9f016636dff58d7c6f7569cd9"
>  SRC_URI[num-iter-0.1.43.sha256sum] = "7d03e6c028c5dc5cac6e2dec0efda81fc887605bb3d884578bb6d6bf7514e252"
>  SRC_URI[num-rational-0.2.4.sha256sum] = "5c000134b5dbf44adc5cb772486d335293351644b801551abe8f75c84cfa4aef"
>  SRC_URI[num-traits-0.1.43.sha256sum] = "92e5113e9fd4cc14ded8e499429f396a20f98c772a47cc8622a736e1ec843c31"
> -SRC_URI[num-traits-0.2.15.sha256sum] = "578ede34cf02f8924ab9447f50c28075b4d3e5b269972345e7e0372b38c6cdcd"
> +SRC_URI[num-traits-0.2.17.sha256sum] = "39e3200413f237f41ab11ad6d161bc7239c84dcb631773ccd7de3dfe4b5c267c"
>  SRC_URI[num_enum-0.5.11.sha256sum] = "1f646caf906c20226733ed5b1374287eb97e3c2a5c227ce668c1f2ce20ae57c9"
>  SRC_URI[num_enum_derive-0.5.11.sha256sum] = "dcbff9bc912032c62bf65ef1d5aea88983b420f4f839db1e9b0c281a25c9c799"
>  SRC_URI[num_threads-0.1.6.sha256sum] = "2819ce041d2ee131036f4fc9d6ae7ae125a3a40e97ba64d04fe799ad9dabbb44"
> @@ -202,140 +621,46 @@ SRC_URI[phf_shared-0.10.0.sha256sum] = "b6796ad771acdc0123d2a88dc428b5e38ef24456
>  SRC_URI[polyval-0.5.3.sha256sum] = "8419d2b623c7c0896ff2d5d96e2cb4ede590fed28fcc34934f4c33c036e620a1"
>  SRC_URI[ppv-lite86-0.2.17.sha256sum] = "5b40af805b3121feab8a3c29f04d8ad262fa8e0561883e7653e024ae4479e6de"
>  SRC_URI[proc-macro-crate-1.1.0.sha256sum] = "1ebace6889caf889b4d3f76becee12e90353f2b8c7d875534a71e5742f8f6f83"
> -SRC_URI[proc-macro2-0.4.30.sha256sum] = "cf3d2011ab5c909338f7887f4fc896d35932e29146c12c8d01da6b22a80ba759"
> -SRC_URI[proc-macro2-1.0.64.sha256sum] = "78803b62cbf1f46fde80d7c0e803111524b9877184cfe7c3033659490ac7a7da"
> -SRC_URI[quote-0.6.13.sha256sum] = "6ce23b6b870e8f94f81fb0a363d65d86675884b34a09043c81e5562f11c1f8e1"
> -SRC_URI[quote-1.0.29.sha256sum] = "573015e8ab27661678357f27dc26460738fd2b6c86e46f386fde94cb5d913105"
> +SRC_URI[proc-macro2-1.0.69.sha256sum] = "134c189feb4956b20f6f547d2cf727d4c0fe06722b20a0eec87ed445a97f92da"
> +SRC_URI[quote-1.0.33.sha256sum] = "5267fca4496028628a95160fc423a33e8b2e6af8a5302579e322e4b520293cae"
>  SRC_URI[rand-0.8.5.sha256sum] = "34af8d1a0e25924bc5b7c43c079c942339d8f0a8b57c39049bef581b46327404"
>  SRC_URI[rand_chacha-0.3.1.sha256sum] = "e6c10a63a0fa32252be49d21e7709d4d4baf8d231c2dbce1eaa8141b9b127d88"
>  SRC_URI[rand_core-0.6.4.sha256sum] = "ec0be4795e2f6a28069bec0b5ff3e2ac9bafc99e6a9a7dc3547996c5c816922c"
>  SRC_URI[regex-1.5.6.sha256sum] = "d83f127d94bdbcda4c8cc2e50f6f84f4b611f69c902699ca385a39c3a75f9ff1"
>  SRC_URI[regex-syntax-0.6.29.sha256sum] = "f162c6dd7b008981e4d40210aca20b4bd0f9b60ca9271061b07f78537722f2e1"
>  SRC_URI[rusticata-macros-4.1.0.sha256sum] = "faf0c4a6ece9950b9abdb62b1cfcf2a68b3b67a10ba445b3bb85be2a293d0632"
> -SRC_URI[rustversion-1.0.13.sha256sum] = "dc31bd9b61a32c31f9650d18add92aa83a49ba979c143eefd27fe7177b05bd5f"
> +SRC_URI[rustversion-1.0.14.sha256sum] = "7ffc183a10b4478d04cbbbfc96d0873219d962dd5accaff2ffbd4ceb7df837f4"
>  SRC_URI[sawp-0.12.1.sha256sum] = "7e74f84d736420afcba72f689a494d275c97cf4775c3fe248f937e9d3bf83e30"
>  SRC_URI[sawp-flags-0.12.1.sha256sum] = "1f2b22023d224b5314d51e53bfb2dbca53dc2cf90a4435aa4feb78172799dad0"
>  SRC_URI[sawp-flags-derive-0.12.1.sha256sum] = "49a585d3c22887d23bb06dd602b8ce96c2a716e1fa89beec8bfb49e466f2d643"
>  SRC_URI[sawp-modbus-0.12.1.sha256sum] = "2cbad9b003999a0f3016fb3603da113ff86f06279ccf6aacb577058168c0568d"
> -SRC_URI[serde-1.0.171.sha256sum] = "30e27d1e4fd7659406c492fd6cfaf2066ba8773de45ca75e855590f856dc34a9"
> -SRC_URI[sha1-0.10.5.sha256sum] = "f04293dc80c3993519f2d7f6f511707ee7094fe0c6d3406feb330cdb3540eba3"
> -SRC_URI[sha2-0.10.7.sha256sum] = "479fb9d862239e610720565ca91403019f2f00410f1864c5aa7479b950a76ed8"
> -SRC_URI[siphasher-0.3.10.sha256sum] = "7bd3e3206899af3f8b12af284fafc038cc1dc2b41d1b89dd17297221c5d225de"
> +SRC_URI[serde-1.0.192.sha256sum] = "bca2a08484b285dcb282d0f67b26cadc0df8b19f8c12502c13d966bf9482f001"
> +SRC_URI[serde_derive-1.0.192.sha256sum] = "d6c7207fbec9faa48073f3e3074cbe553af6ea512d7c21ba46e434e70ea9fbc1"
> +SRC_URI[sha1-0.10.6.sha256sum] = "e3bf829a2d51ab4a5ddf1352d8470c140cadc8301b2ae1789db023f01cedd6ba"
> +SRC_URI[sha2-0.10.8.sha256sum] = "793db75ad2bcafc3ffa7c68b215fee268f537982cd901d132f89c6343f3a3dc8"
> +SRC_URI[siphasher-0.3.11.sha256sum] = "38b58827f4464d87d377d175e90bf58eb00fd8716ff0a62f80356b5e61555d0d"
>  SRC_URI[snmp-parser-0.9.0.sha256sum] = "773a26ad6742636f4259e7cc32262efb31feabd56bc34f0b2f28de9801aa24b3"
>  SRC_URI[subtle-2.4.1.sha256sum] = "6bdef32e8150c2a081110b42772ffe7d7c9032b606bc226c8260fd97e0976601"
> -SRC_URI[syn-0.15.44.sha256sum] = "9ca4b3b69a77cbe1ffc9e198781b7acb0c7365a883670e8f1c1bc66fba79a5c5"
>  SRC_URI[syn-1.0.109.sha256sum] = "72b64191b275b66ffe2469e8af2c1cfe3bafa67b529ead792a6d0160888b4237"
> -SRC_URI[syn-2.0.25.sha256sum] = "15e3fc8c0c74267e2df136e5e5fb656a464158aa57624053375eb9c8c6e25ae2"
> +SRC_URI[syn-2.0.39.sha256sum] = "23e78b90f2fcf45d3e842032ce32e3f2d1545ba6636271dcbf24fa306d87be7a"
>  SRC_URI[synstructure-0.12.6.sha256sum] = "f36bdaa60a83aca3921b5259d5400cbf5e90fc51931376a9bd4a0eb79aa7210f"
>  SRC_URI[test-case-1.1.0.sha256sum] = "956044ef122917dde830c19dec5f76d0670329fde4104836d62ebcb14f4865f1"
> -SRC_URI[thiserror-1.0.43.sha256sum] = "a35fc5b8971143ca348fa6df4f024d4d55264f3468c71ad1c2f365b0a4d58c42"
> -SRC_URI[thiserror-impl-1.0.43.sha256sum] = "463fe12d7993d3b327787537ce8dd4dfa058de32fc2b195ef3cde03dc4771e8f"
> +SRC_URI[thiserror-1.0.50.sha256sum] = "f9a7210f5c9a7156bb50aa36aed4c95afb51df0df00713949448cf9e97d382d2"
> +SRC_URI[thiserror-impl-1.0.50.sha256sum] = "266b2e40bc00e5a6c09c3584011e08b06f123c00362c92b975ba9843aaaa14b8"
>  SRC_URI[time-0.3.13.sha256sum] = "db76ff9fa4b1458b3c7f077f3ff9887394058460d21e634355b273aaf11eea45"
>  SRC_URI[time-macros-0.2.4.sha256sum] = "42657b1a6f4d817cda8e7a0ace261fe0cc946cf3a80314390b22cc61ae080792"
>  SRC_URI[tls-parser-0.11.0.sha256sum] = "409206e2de64edbf7ea99a44ac31680daf9ef1a57895fb3c5bd738a903691be0"
>  SRC_URI[toml-0.5.11.sha256sum] = "f4f7f0dd8d50a853a531c426359045b1998f04219d88799810762cd4ad314234"
> -SRC_URI[typenum-1.16.0.sha256sum] = "497961ef93d974e23eb6f433eb5fe1b7930b659f06d12dec6fc44a8f554c0bba"
> -SRC_URI[unicode-ident-1.0.10.sha256sum] = "22049a19f4a68748a168c0fc439f9516686aa045927ff767eca0a85101fb6e73"
> -SRC_URI[unicode-xid-0.1.0.sha256sum] = "fc72304796d0818e357ead4e000d19c9c174ab23dc11093ac919054d20a6a7fc"
> +SRC_URI[typenum-1.17.0.sha256sum] = "42ff0bf0c66b8238c6f3b578df37d0b7848e55df8577b3f74f92a69acceeb825"
> +SRC_URI[unicode-ident-1.0.12.sha256sum] = "3354b9ac3fae1ff6755cb6db53683adb661634f67557942dea4facebec0fee4b"
>  SRC_URI[unicode-xid-0.2.4.sha256sum] = "f962df74c8c05a667b5ee8bcf162993134c104e96440b663c8daa176dc772d8c"
>  SRC_URI[universal-hash-0.4.1.sha256sum] = "9f214e8f697e925001e66ec2c6e37a4ef93f0f78c2eed7814394e10c62025b05"
>  SRC_URI[uuid-0.8.2.sha256sum] = "bc5cf98d8186244414c848017f0e2676b3fcb46807f6668a97dfe67359a3c4b7"
>  SRC_URI[version_check-0.9.4.sha256sum] = "49874b5167b65d7193b8aba1567f5c7d93d001cafc34600cee003eda787e483f"
>  SRC_URI[wasi-0.11.0+wasi-snapshot-preview1.sha256sum] = "9c8d87e72b64a3b4db28d11ce29237c246188f4f51057d65a7eab63b7987e423"
>  SRC_URI[widestring-0.4.3.sha256sum] = "c168940144dd21fd8046987c16a46a33d5fc84eec29ef9dcddc2ac9e31526b7c"
> -SRC_URI[x509-parser-0.15.0.sha256sum] = "bab0c2f54ae1d92f4fcb99c0b7ccf0b1e3451cbd395e5f115ccbdbcb18d4f634"
> +SRC_URI[x509-parser-0.15.1.sha256sum] = "7069fba5b66b9193bd2c5d3d4ff12b839118f6bcbef5328efafafb5395cf63da"
>  # from rust/vendor/base64/Cargo.lock
> -SRC_URI += " \
> -    crate://crates.io/ansi_term/0.12.1 \
> -    crate://crates.io/atty/0.2.14 \
> -    crate://crates.io/autocfg/0.1.8 \
> -    crate://crates.io/autocfg/1.1.0 \
> -    crate://crates.io/bitflags/1.3.2 \
> -    crate://crates.io/bstr/0.2.17 \
> -    crate://crates.io/bumpalo/3.11.1 \
> -    crate://crates.io/cast/0.2.7 \
> -    crate://crates.io/cast/0.3.0 \
> -    crate://crates.io/cfg-if/1.0.0 \
> -    crate://crates.io/clap/2.34.0 \
> -    crate://crates.io/cloudabi/0.0.3 \
> -    crate://crates.io/criterion/0.3.2 \
> -    crate://crates.io/criterion-plot/0.4.5 \
> -    crate://crates.io/crossbeam-channel/0.5.6 \
> -    crate://crates.io/crossbeam-deque/0.8.2 \
> -    crate://crates.io/crossbeam-epoch/0.9.11 \
> -    crate://crates.io/crossbeam-utils/0.8.12 \
> -    crate://crates.io/csv/1.1.6 \
> -    crate://crates.io/csv-core/0.1.10 \
> -    crate://crates.io/either/1.8.0 \
> -    crate://crates.io/fuchsia-cprng/0.1.1 \
> -    crate://crates.io/heck/0.3.3 \
> -    crate://crates.io/hermit-abi/0.1.19 \
> -    crate://crates.io/itertools/0.9.0 \
> -    crate://crates.io/itertools/0.10.5 \
> -    crate://crates.io/itoa/0.4.8 \
> -    crate://crates.io/itoa/1.0.4 \
> -    crate://crates.io/js-sys/0.3.60 \
> -    crate://crates.io/lazy_static/1.4.0 \
> -    crate://crates.io/libc/0.2.135 \
> -    crate://crates.io/log/0.4.17 \
> -    crate://crates.io/memchr/2.5.0 \
> -    crate://crates.io/memoffset/0.6.5 \
> -    crate://crates.io/num-traits/0.2.15 \
> -    crate://crates.io/num_cpus/1.13.1 \
> -    crate://crates.io/once_cell/1.15.0 \
> -    crate://crates.io/oorandom/11.1.3 \
> -    crate://crates.io/plotters/0.2.15 \
> -    crate://crates.io/proc-macro-error/1.0.4 \
> -    crate://crates.io/proc-macro-error-attr/1.0.4 \
> -    crate://crates.io/proc-macro2/1.0.47 \
> -    crate://crates.io/quote/1.0.21 \
> -    crate://crates.io/rand/0.6.5 \
> -    crate://crates.io/rand_chacha/0.1.1 \
> -    crate://crates.io/rand_core/0.3.1 \
> -    crate://crates.io/rand_core/0.4.2 \
> -    crate://crates.io/rand_hc/0.1.0 \
> -    crate://crates.io/rand_isaac/0.1.1 \
> -    crate://crates.io/rand_jitter/0.1.4 \
> -    crate://crates.io/rand_os/0.1.3 \
> -    crate://crates.io/rand_pcg/0.1.2 \
> -    crate://crates.io/rand_xorshift/0.1.1 \
> -    crate://crates.io/rayon/1.5.3 \
> -    crate://crates.io/rayon-core/1.9.3 \
> -    crate://crates.io/rdrand/0.4.0 \
> -    crate://crates.io/regex/1.6.0 \
> -    crate://crates.io/regex-automata/0.1.10 \
> -    crate://crates.io/regex-syntax/0.6.27 \
> -    crate://crates.io/rustc_version/0.4.0 \
> -    crate://crates.io/ryu/1.0.11 \
> -    crate://crates.io/same-file/1.0.6 \
> -    crate://crates.io/scopeguard/1.1.0 \
> -    crate://crates.io/semver/1.0.14 \
> -    crate://crates.io/serde/1.0.146 \
> -    crate://crates.io/serde_derive/1.0.146 \
> -    crate://crates.io/serde_json/1.0.87 \
> -    crate://crates.io/strsim/0.8.0 \
> -    crate://crates.io/structopt/0.3.26 \
> -    crate://crates.io/structopt-derive/0.4.18 \
> -    crate://crates.io/syn/1.0.103 \
> -    crate://crates.io/textwrap/0.11.0 \
> -    crate://crates.io/tinytemplate/1.2.1 \
> -    crate://crates.io/unicode-ident/1.0.5 \
> -    crate://crates.io/unicode-segmentation/1.10.0 \
> -    crate://crates.io/unicode-width/0.1.10 \
> -    crate://crates.io/vec_map/0.8.2 \
> -    crate://crates.io/version_check/0.9.4 \
> -    crate://crates.io/walkdir/2.3.2 \
> -    crate://crates.io/wasm-bindgen/0.2.83 \
> -    crate://crates.io/wasm-bindgen-backend/0.2.83 \
> -    crate://crates.io/wasm-bindgen-macro/0.2.83 \
> -    crate://crates.io/wasm-bindgen-macro-support/0.2.83 \
> -    crate://crates.io/wasm-bindgen-shared/0.2.83 \
> -    crate://crates.io/web-sys/0.3.60 \
> -    crate://crates.io/winapi/0.3.9 \
> -    crate://crates.io/winapi-i686-pc-windows-gnu/0.4.0 \
> -    crate://crates.io/winapi-util/0.1.5 \
> -    crate://crates.io/winapi-x86_64-pc-windows-gnu/0.4.0 \
> -"
>
>  SRC_URI[ansi_term-0.12.1.sha256sum] = "d52a9bb7ec0cf484c551830a7ce27bd20d67eac647e1befb56b0be4ee39a55d2"
>  SRC_URI[atty-0.2.14.sha256sum] = "d9b39be18770d11421cdb1b9947a45dd3f37e93092cbf377614828a319d5fee8"
> @@ -426,38 +751,74 @@ SRC_URI[winapi-0.3.9.sha256sum] = "5c839a674fcd7a98952e593242ea400abe93992746761
>  SRC_URI[winapi-i686-pc-windows-gnu-0.4.0.sha256sum] = "ac3b87c63620426dd9b991e5ce0329eff545bccbbb34f3be09ff6fb6ab51b7b6"
>  SRC_URI[winapi-util-0.1.5.sha256sum] = "70ec6ce85bb158151cae5e5c87f95a8e97d2c0c4b001223f33a334e3ce5de178"
>  SRC_URI[winapi-x86_64-pc-windows-gnu-0.4.0.sha256sum] = "712e227841d057c1ee1cd2fb22fa7e5a5461ae8e48fa2ca79ec42cfc1931183f"
> +# from rust/vendor/failure/Cargo.lock
> +
> +SRC_URI[backtrace-0.3.46.sha256sum] = "b1e692897359247cc6bb902933361652380af0f1b7651ae5c5013407f30e109e"
> +SRC_URI[backtrace-sys-0.1.37.sha256sum] = "18fbebbe1c9d1f383a9cc7e8ccdb471b91c8d024ee9c2ca5b5346121fe8b4399"
> +SRC_URI[cc-1.0.52.sha256sum] = "c3d87b23d6a92cd03af510a5ade527033f6aa6fa92161e2d5863a907d4c5e31d"
> +SRC_URI[cfg-if-0.1.10.sha256sum] = "4785bdd1c96b2a846b2bd7cc02e86b6b3dbf14e7e53446c4f54c92a361040822"
> +SRC_URI[failure_derive-0.1.7.sha256sum] = "030a733c8287d6213886dd487564ff5c8f6aae10278b3588ed177f9d18f8d231"
> +SRC_URI[libc-0.2.69.sha256sum] = "99e85c08494b21a9054e7fe1374a732aeadaff3980b6990b94bfd3a70f690005"
> +SRC_URI[proc-macro2-1.0.12.sha256sum] = "8872cf6f48eee44265156c111456a700ab3483686b3f96df4cf5481c89157319"
> +SRC_URI[quote-1.0.4.sha256sum] = "4c1f4b0efa5fc5e8ceb705136bfee52cfdb6a4e3509f770b478cd6ed434232a7"
> +SRC_URI[rustc-demangle-0.1.16.sha256sum] = "4c691c0e608126e00913e33f0ccf3727d5fc84573623b8d65b2df340b5201783"
> +SRC_URI[syn-1.0.18.sha256sum] = "410a7488c0a728c7ceb4ad59b9567eb4053d02e8cc7f5c0e0eeeb39518369213"
> +SRC_URI[synstructure-0.12.3.sha256sum] = "67656ea1dc1b41b1451851562ea232ec2e5a80242139f7e679ceccfb5d61f545"
> +SRC_URI[unicode-xid-0.2.0.sha256sum] = "826e7639553986605ec5979c7dd957c7895e93eabed50ab2ffa7f6128a75097c"
> +# from rust/vendor/toml/Cargo.lock
> +
> +SRC_URI[autocfg-1.1.0.sha256sum] = "d468802bab17cbc0cc575e9b053f41e72aa36bfa6b7f55e3529ffa43161b97fa"
> +SRC_URI[hashbrown-0.12.3.sha256sum] = "8a9ee70c43aaf417c914396645a0fa852624801b24ebb7ae78fe8272889ac888"
> +SRC_URI[indexmap-1.9.2.sha256sum] = "1885e79c1fc4b10f0e172c475f458b7f7b93061064d98c3293e98c5ba0c8b399"
> +SRC_URI[itoa-1.0.5.sha256sum] = "fad582f4b9e86b6caa621cabeb0963332d92eea04729ab12892c2533951e6440"
> +SRC_URI[proc-macro2-1.0.50.sha256sum] = "6ef7d57beacfaf2d8aee5937dab7b7f28de3cb8b1828479bb5de2a7106f2bae2"
> +SRC_URI[quote-1.0.23.sha256sum] = "8856d8364d252a14d474036ea1358d63c9e6965c8e5c1885c18f73d70bff9c7b"
> +SRC_URI[ryu-1.0.12.sha256sum] = "7b4b9743ed687d4b4bcedf9ff5eaa7398495ae14e61cba0a295704edbc7decde"
> +SRC_URI[serde-1.0.152.sha256sum] = "bb7d1f0d3021d347a83e556fc4683dea2ea09d87bccdf88ff5c12545d89d5efb"
> +SRC_URI[serde_derive-1.0.152.sha256sum] = "af487d118eecd09402d70a5d72551860e788df87b464af30e5ea6a38c75c541e"
> +SRC_URI[serde_json-1.0.91.sha256sum] = "877c235533714907a8c2464236f5c4b2a17262ef1bd71f38f35ea592c8da6883"
> +SRC_URI[syn-1.0.107.sha256sum] = "1f4064b5b16e03ae50984a5a8ed5d4f8803e6bc1fd170a3cda91a1be4b18e3f5"
> +SRC_URI[unicode-ident-1.0.6.sha256sum] = "84a22b9f218b40614adcb3f4ff08b703773ad44fa9423e4e0d346d5db86e4ebc"
> +# from rust/vendor/nom/Cargo.lock
> +
> +SRC_URI[autocfg-1.0.1.sha256sum] = "cdb031dd78e28731d87d56cc8ffef4a8f36ca26c38fe2de700543e627f8a464a"
> +SRC_URI[bit-set-0.5.2.sha256sum] = "6e11e16035ea35e4e5997b393eacbf6f63983188f7a2ad25bfb13465f5ad59de"
> +SRC_URI[bit-vec-0.6.3.sha256sum] = "349f9b6a179ed607305526ca489b34ad0a41aed5f7980fa90eb03160b69598fb"
> +SRC_URI[bitflags-1.3.2.sha256sum] = "bef38d45163c2f1dde094a7dfd33ccf595c92905c8f8f4fdc18d06fb1037718a"
> +SRC_URI[byteorder-1.4.3.sha256sum] = "14c189c53d098945499cdfa7ecc63567cf3886b3332b312a5b4585d8d3a6a610"
> +SRC_URI[cfg-if-1.0.0.sha256sum] = "baf1de4339761588bc0619e3cbc0120ee582ebb74b53b4efbf79117bd2da40fd"
> +SRC_URI[doc-comment-0.3.3.sha256sum] = "fea41bba32d969b513997752735605054bc0dfa92b4c56bf1189f2e174be7a10"
> +SRC_URI[fnv-1.0.7.sha256sum] = "3f9eec918d3f24069decb9af1554cad7c880e2da24a9afd88aca000531ab82c1"
> +SRC_URI[getrandom-0.2.3.sha256sum] = "7fcd999463524c52659517fe2cea98493cfe485d10565e7b0fb07dbba7ad2753"
> +SRC_URI[lazy_static-1.4.0.sha256sum] = "e2abad23fbc42b3700f2f279844dc832adb2b2eb069b2df918f455c4e18cc646"
> +SRC_URI[libc-0.2.106.sha256sum] = "a60553f9a9e039a333b4e9b20573b9e9b9c0bb3a11e201ccc48ef4283456d673"
> +SRC_URI[memchr-2.4.1.sha256sum] = "308cc39be01b73d0d18f82a0e7b2a3df85245f84af96fdddc5d202d27e47b86a"
> +SRC_URI[minimal-lexical-0.2.1.sha256sum] = "68354c5c6bd36d73ff3feceb05efa59b6acb7626617f4962be322a825e61f79a"
> +SRC_URI[num-traits-0.2.14.sha256sum] = "9a64b1ec5cda2586e284722486d802acf1f7dbdc623e2bfc57e65ca1cd099290"
> +SRC_URI[ppv-lite86-0.2.15.sha256sum] = "ed0cfbc8191465bed66e1718596ee0b0b35d5ee1f41c5df2189d0fe8bde535ba"
> +SRC_URI[proptest-1.0.0.sha256sum] = "1e0d9cc07f18492d879586c92b485def06bc850da3118075cd45d50e9c95b0e5"
> +SRC_URI[quick-error-1.2.3.sha256sum] = "a1d01941d82fa2ab50be1e79e6714289dd7cde78eba4c074bc5a4374f650dfe0"
> +SRC_URI[quick-error-2.0.1.sha256sum] = "a993555f31e5a609f617c12db6250dedcac1b0a85076912c436e6fc9b2c8e6a3"
> +SRC_URI[rand-0.8.4.sha256sum] = "2e7573632e6454cf6b99d7aac4ccca54be06da05aca2ef7423d22d27d4d4bcd8"
> +SRC_URI[rand_chacha-0.3.1.sha256sum] = "e6c10a63a0fa32252be49d21e7709d4d4baf8d231c2dbce1eaa8141b9b127d88"
> +SRC_URI[rand_core-0.6.3.sha256sum] = "d34f1408f55294453790c48b2f1ebbb1c5b4b7563eb1f418bcfcfdbb06ebb4e7"
> +SRC_URI[rand_hc-0.3.1.sha256sum] = "d51e9f596de227fda2ea6c84607f5558e196eeaf43c986b724ba4fb8fdf497e7"
> +SRC_URI[rand_xorshift-0.3.0.sha256sum] = "d25bf25ec5ae4a3f1b92f929810509a2f53d7dca2f50b794ff57e3face536c8f"
> +SRC_URI[redox_syscall-0.2.10.sha256sum] = "8383f39639269cde97d255a32bdb68c047337295414940c68bdd30c2e13203ff"
> +SRC_URI[regex-syntax-0.6.25.sha256sum] = "f497285884f3fcff424ffc933e56d7cbca511def0c9831a7f9b5f6153e3cc89b"
> +SRC_URI[remove_dir_all-0.5.3.sha256sum] = "3acd125665422973a33ac9d3dd2df85edad0f4ae9b00dafb1a05e43a9f5ef8e7"
> +SRC_URI[rusty-fork-0.3.0.sha256sum] = "cb3dcc6e454c328bb824492db107ab7c0ae8fcffe4ad210136ef014458c1bc4f"
> +SRC_URI[tempfile-3.2.0.sha256sum] = "dac1c663cfc93810f88aed9b8941d48cabf856a1b111c29a40439018d870eb22"
> +SRC_URI[wait-timeout-0.2.0.sha256sum] = "9f200f5b12eb75f8c1ed65abd4b2db8a6e1b138a20de009dacee265a2498f3f6"
> +SRC_URI[wasi-0.10.2+wasi-snapshot-preview1.sha256sum] = "fd6fbd9a79829dd1ad0cc20627bf1ed606756a7f77edff7b66b7064f9cb327c6"
> +SRC_URI[winapi-0.3.9.sha256sum] = "5c839a674fcd7a98952e593242ea400abe93992746761e38641405d28b00f419"
> +SRC_URI[winapi-i686-pc-windows-gnu-0.4.0.sha256sum] = "ac3b87c63620426dd9b991e5ce0329eff545bccbbb34f3be09ff6fb6ab51b7b6"
> +SRC_URI[winapi-x86_64-pc-windows-gnu-0.4.0.sha256sum] = "712e227841d057c1ee1cd2fb22fa7e5a5461ae8e48fa2ca79ec42cfc1931183f"
> +# from rust/vendor/brotli-decompressor/Cargo.lock
> +
> +SRC_URI[alloc-no-stdlib-2.0.4.sha256sum] = "cc7bb162ec39d46ab1ca8c77bf72e890535becd1751bb45f64c597edb4c8c6b3"
> +SRC_URI[alloc-stdlib-0.2.2.sha256sum] = "94fb8275041c72129eb51b7d0322c29b8387a0386127718b096429201a5d6ece"
>  # from rust/vendor/displaydoc/Cargo.lock
> -SRC_URI += " \
> -    crate://crates.io/ansi_term/0.11.0 \
> -    crate://crates.io/basic-toml/0.1.2 \
> -    crate://crates.io/ctor/0.1.26 \
> -    crate://crates.io/difference/2.0.0 \
> -    crate://crates.io/glob/0.3.1 \
> -    crate://crates.io/itoa/1.0.6 \
> -    crate://crates.io/libc/0.2.142 \
> -    crate://crates.io/once_cell/1.17.1 \
> -    crate://crates.io/output_vt100/0.1.3 \
> -    crate://crates.io/pretty_assertions/0.6.1 \
> -    crate://crates.io/proc-macro2/1.0.56 \
> -    crate://crates.io/quote/1.0.26 \
> -    crate://crates.io/rustversion/1.0.12 \
> -    crate://crates.io/ryu/1.0.13 \
> -    crate://crates.io/serde/1.0.160 \
> -    crate://crates.io/serde_derive/1.0.160 \
> -    crate://crates.io/serde_json/1.0.96 \
> -    crate://crates.io/static_assertions/1.1.0 \
> -    crate://crates.io/syn/1.0.109 \
> -    crate://crates.io/syn/2.0.15 \
> -    crate://crates.io/termcolor/1.2.0 \
> -    crate://crates.io/thiserror/1.0.40 \
> -    crate://crates.io/thiserror-impl/1.0.40 \
> -    crate://crates.io/trybuild/1.0.80 \
> -    crate://crates.io/unicode-ident/1.0.8 \
> -    crate://crates.io/winapi/0.3.9 \
> -    crate://crates.io/winapi-i686-pc-windows-gnu/0.4.0 \
> -    crate://crates.io/winapi-util/0.1.5 \
> -    crate://crates.io/winapi-x86_64-pc-windows-gnu/0.4.0 \
> -"
>
>  SRC_URI[ansi_term-0.11.0.sha256sum] = "ee49baf6cb617b853aa8d93bf420db2383fab46d314482ca2803b40d5fde979b"
>  SRC_URI[basic-toml-0.1.2.sha256sum] = "5c0de75129aa8d0cceaf750b89013f0e08804d6ec61416da787b35ad0d7cddf1"
> @@ -489,60 +850,6 @@ SRC_URI[winapi-i686-pc-windows-gnu-0.4.0.sha256sum] = "ac3b87c63620426dd9b991e5c
>  SRC_URI[winapi-util-0.1.5.sha256sum] = "70ec6ce85bb158151cae5e5c87f95a8e97d2c0c4b001223f33a334e3ce5de178"
>  SRC_URI[winapi-x86_64-pc-windows-gnu-0.4.0.sha256sum] = "712e227841d057c1ee1cd2fb22fa7e5a5461ae8e48fa2ca79ec42cfc1931183f"
>  # from rust/vendor/asn1-rs/Cargo.lock
> -SRC_URI += " \
> -    crate://crates.io/asn1-rs/0.5.1 \
> -    crate://crates.io/asn1-rs-derive/0.4.0 \
> -    crate://crates.io/asn1-rs-impl/0.1.0 \
> -    crate://crates.io/atty/0.2.14 \
> -    crate://crates.io/autocfg/1.1.0 \
> -    crate://crates.io/base64/0.13.1 \
> -    crate://crates.io/basic-toml/0.1.2 \
> -    crate://crates.io/bitvec/1.0.1 \
> -    crate://crates.io/colored/2.0.0 \
> -    crate://crates.io/cookie-factory/0.3.2 \
> -    crate://crates.io/displaydoc/0.2.3 \
> -    crate://crates.io/funty/2.0.0 \
> -    crate://crates.io/glob/0.3.1 \
> -    crate://crates.io/hermit-abi/0.1.19 \
> -    crate://crates.io/hex-literal/0.3.4 \
> -    crate://crates.io/itoa/1.0.6 \
> -    crate://crates.io/lazy_static/1.4.0 \
> -    crate://crates.io/libc/0.2.139 \
> -    crate://crates.io/memchr/2.5.0 \
> -    crate://crates.io/minimal-lexical/0.2.1 \
> -    crate://crates.io/nom/7.1.3 \
> -    crate://crates.io/num-bigint/0.4.3 \
> -    crate://crates.io/num-integer/0.1.45 \
> -    crate://crates.io/num-traits/0.2.15 \
> -    crate://crates.io/oid-registry/0.6.1 \
> -    crate://crates.io/once_cell/1.17.1 \
> -    crate://crates.io/pem/1.1.1 \
> -    crate://crates.io/proc-macro2/1.0.51 \
> -    crate://crates.io/quote/1.0.23 \
> -    crate://crates.io/radium/0.7.0 \
> -    crate://crates.io/rusticata-macros/4.1.0 \
> -    crate://crates.io/ryu/1.0.13 \
> -    crate://crates.io/serde/1.0.152 \
> -    crate://crates.io/serde_derive/1.0.152 \
> -    crate://crates.io/serde_json/1.0.94 \
> -    crate://crates.io/syn/1.0.109 \
> -    crate://crates.io/synstructure/0.12.6 \
> -    crate://crates.io/tap/1.0.1 \
> -    crate://crates.io/termcolor/1.2.0 \
> -    crate://crates.io/thiserror/1.0.39 \
> -    crate://crates.io/thiserror-impl/1.0.39 \
> -    crate://crates.io/time/0.3.20 \
> -    crate://crates.io/time-core/0.1.0 \
> -    crate://crates.io/time-macros/0.2.8 \
> -    crate://crates.io/trybuild/1.0.79 \
> -    crate://crates.io/unicode-ident/1.0.8 \
> -    crate://crates.io/unicode-xid/0.2.4 \
> -    crate://crates.io/winapi/0.3.9 \
> -    crate://crates.io/winapi-i686-pc-windows-gnu/0.4.0 \
> -    crate://crates.io/winapi-util/0.1.5 \
> -    crate://crates.io/winapi-x86_64-pc-windows-gnu/0.4.0 \
> -    crate://crates.io/wyz/0.5.1 \
> -"
>
>  SRC_URI[asn1-rs-0.5.1.sha256sum] = "cf6690c370453db30743b373a60ba498fc0d6d83b11f4abfd87a84a075db5dd4"
>  SRC_URI[asn1-rs-derive-0.4.0.sha256sum] = "726535892e8eae7e70657b4c8ea93d26b8553afb1ce617caee529ef96d7dee6c"
> @@ -596,383 +903,22 @@ SRC_URI[winapi-i686-pc-windows-gnu-0.4.0.sha256sum] = "ac3b87c63620426dd9b991e5c
>  SRC_URI[winapi-util-0.1.5.sha256sum] = "70ec6ce85bb158151cae5e5c87f95a8e97d2c0c4b001223f33a334e3ce5de178"
>  SRC_URI[winapi-x86_64-pc-windows-gnu-0.4.0.sha256sum] = "712e227841d057c1ee1cd2fb22fa7e5a5461ae8e48fa2ca79ec42cfc1931183f"
>  SRC_URI[wyz-0.5.1.sha256sum] = "05f360fc0b24296329c78fda852a1e9ae82de9cf7b27dae4b7f62f118f77b9ed"
> -# from rust/vendor/flate2/Cargo.lock
> -SRC_URI += " \
> -    crate://crates.io/adler/1.0.2 \
> -    crate://crates.io/cc/1.0.73 \
> -    crate://crates.io/cfg-if/1.0.0 \
> -    crate://crates.io/cloudflare-zlib-sys/0.3.0 \
> -    crate://crates.io/cmake/0.1.48 \
> -    crate://crates.io/crc32fast/1.3.2 \
> -    crate://crates.io/getrandom/0.2.6 \
> -    crate://crates.io/libc/0.2.124 \
> -    crate://crates.io/libz-ng-sys/1.1.8 \
> -    crate://crates.io/libz-sys/1.1.8 \
> -    crate://crates.io/miniz_oxide/0.7.1 \
> -    crate://crates.io/pkg-config/0.3.25 \
> -    crate://crates.io/ppv-lite86/0.2.16 \
> -    crate://crates.io/quickcheck/1.0.3 \
> -    crate://crates.io/rand/0.8.5 \
> -    crate://crates.io/rand_chacha/0.3.1 \
> -    crate://crates.io/rand_core/0.6.3 \
> -    crate://crates.io/vcpkg/0.2.15 \
> -    crate://crates.io/wasi/0.10.2+wasi-snapshot-preview1 \
> -"
> -
> -SRC_URI[adler-1.0.2.sha256sum] = "f26201604c87b1e01bd3d98f8d5d9a8fcbb815e8cedb41ffccbeb4bf593a35fe"
> -SRC_URI[cc-1.0.73.sha256sum] = "2fff2a6927b3bb87f9595d67196a70493f627687a71d87a0d692242c33f58c11"
> -SRC_URI[cfg-if-1.0.0.sha256sum] = "baf1de4339761588bc0619e3cbc0120ee582ebb74b53b4efbf79117bd2da40fd"
> -SRC_URI[cloudflare-zlib-sys-0.3.0.sha256sum] = "2040b6d1edfee6d75f172d81e2d2a7807534f3f294ce18184c70e7bb0105cd6f"
> -SRC_URI[cmake-0.1.48.sha256sum] = "e8ad8cef104ac57b68b89df3208164d228503abbdce70f6880ffa3d970e7443a"
> -SRC_URI[crc32fast-1.3.2.sha256sum] = "b540bd8bc810d3885c6ea91e2018302f68baba2129ab3e88f32389ee9370880d"
> -SRC_URI[getrandom-0.2.6.sha256sum] = "9be70c98951c83b8d2f8f60d7065fa6d5146873094452a1008da8c2f1e4205ad"
> -SRC_URI[libc-0.2.124.sha256sum] = "21a41fed9d98f27ab1c6d161da622a4fa35e8a54a8adc24bbf3ddd0ef70b0e50"
> -SRC_URI[libz-ng-sys-1.1.8.sha256sum] = "4399ae96a9966bf581e726de86969f803a81b7ce795fcd5480e640589457e0f2"
> -SRC_URI[libz-sys-1.1.8.sha256sum] = "9702761c3935f8cc2f101793272e202c72b99da8f4224a19ddcf1279a6450bbf"
> -SRC_URI[miniz_oxide-0.7.1.sha256sum] = "e7810e0be55b428ada41041c41f32c9f1a42817901b4ccf45fa3d4b6561e74c7"
> -SRC_URI[pkg-config-0.3.25.sha256sum] = "1df8c4ec4b0627e53bdf214615ad287367e482558cf84b109250b37464dc03ae"
> -SRC_URI[ppv-lite86-0.2.16.sha256sum] = "eb9f9e6e233e5c4a35559a617bf40a4ec447db2e84c20b55a6f83167b7e57872"
> -SRC_URI[quickcheck-1.0.3.sha256sum] = "588f6378e4dd99458b60ec275b4477add41ce4fa9f64dcba6f15adccb19b50d6"
> -SRC_URI[rand-0.8.5.sha256sum] = "34af8d1a0e25924bc5b7c43c079c942339d8f0a8b57c39049bef581b46327404"
> -SRC_URI[rand_chacha-0.3.1.sha256sum] = "e6c10a63a0fa32252be49d21e7709d4d4baf8d231c2dbce1eaa8141b9b127d88"
> -SRC_URI[rand_core-0.6.3.sha256sum] = "d34f1408f55294453790c48b2f1ebbb1c5b4b7563eb1f418bcfcfdbb06ebb4e7"
> -SRC_URI[vcpkg-0.2.15.sha256sum] = "accd4ea62f7bb7a82fe23066fb0957d48ef677f6eeb8215f372f52e48bb32426"
> -SRC_URI[wasi-0.10.2+wasi-snapshot-preview1.sha256sum] = "fd6fbd9a79829dd1ad0cc20627bf1ed606756a7f77edff7b66b7064f9cb327c6"
> -# from rust/vendor/toml/Cargo.lock
> -SRC_URI += " \
> -    crate://crates.io/autocfg/1.1.0 \
> -    crate://crates.io/hashbrown/0.12.3 \
> -    crate://crates.io/indexmap/1.9.2 \
> -    crate://crates.io/itoa/1.0.5 \
> -    crate://crates.io/proc-macro2/1.0.50 \
> -    crate://crates.io/quote/1.0.23 \
> -    crate://crates.io/ryu/1.0.12 \
> -    crate://crates.io/serde/1.0.152 \
> -    crate://crates.io/serde_derive/1.0.152 \
> -    crate://crates.io/serde_json/1.0.91 \
> -    crate://crates.io/syn/1.0.107 \
> -    crate://crates.io/unicode-ident/1.0.6 \
> -"
> -
> -SRC_URI[autocfg-1.1.0.sha256sum] = "d468802bab17cbc0cc575e9b053f41e72aa36bfa6b7f55e3529ffa43161b97fa"
> -SRC_URI[hashbrown-0.12.3.sha256sum] = "8a9ee70c43aaf417c914396645a0fa852624801b24ebb7ae78fe8272889ac888"
> -SRC_URI[indexmap-1.9.2.sha256sum] = "1885e79c1fc4b10f0e172c475f458b7f7b93061064d98c3293e98c5ba0c8b399"
> -SRC_URI[itoa-1.0.5.sha256sum] = "fad582f4b9e86b6caa621cabeb0963332d92eea04729ab12892c2533951e6440"
> -SRC_URI[proc-macro2-1.0.50.sha256sum] = "6ef7d57beacfaf2d8aee5937dab7b7f28de3cb8b1828479bb5de2a7106f2bae2"
> -SRC_URI[quote-1.0.23.sha256sum] = "8856d8364d252a14d474036ea1358d63c9e6965c8e5c1885c18f73d70bff9c7b"
> -SRC_URI[ryu-1.0.12.sha256sum] = "7b4b9743ed687d4b4bcedf9ff5eaa7398495ae14e61cba0a295704edbc7decde"
> -SRC_URI[serde-1.0.152.sha256sum] = "bb7d1f0d3021d347a83e556fc4683dea2ea09d87bccdf88ff5c12545d89d5efb"
> -SRC_URI[serde_derive-1.0.152.sha256sum] = "af487d118eecd09402d70a5d72551860e788df87b464af30e5ea6a38c75c541e"
> -SRC_URI[serde_json-1.0.91.sha256sum] = "877c235533714907a8c2464236f5c4b2a17262ef1bd71f38f35ea592c8da6883"
> -SRC_URI[syn-1.0.107.sha256sum] = "1f4064b5b16e03ae50984a5a8ed5d4f8803e6bc1fd170a3cda91a1be4b18e3f5"
> -SRC_URI[unicode-ident-1.0.6.sha256sum] = "84a22b9f218b40614adcb3f4ff08b703773ad44fa9423e4e0d346d5db86e4ebc"
> -# from rust/vendor/nom/Cargo.lock
> -SRC_URI += " \
> -    crate://crates.io/autocfg/1.0.1 \
> -    crate://crates.io/bit-set/0.5.2 \
> -    crate://crates.io/bit-vec/0.6.3 \
> -    crate://crates.io/bitflags/1.3.2 \
> -    crate://crates.io/byteorder/1.4.3 \
> -    crate://crates.io/cfg-if/1.0.0 \
> -    crate://crates.io/doc-comment/0.3.3 \
> -    crate://crates.io/fnv/1.0.7 \
> -    crate://crates.io/getrandom/0.2.3 \
> -    crate://crates.io/lazy_static/1.4.0 \
> -    crate://crates.io/libc/0.2.106 \
> -    crate://crates.io/memchr/2.4.1 \
> -    crate://crates.io/minimal-lexical/0.2.1 \
> -    crate://crates.io/num-traits/0.2.14 \
> -    crate://crates.io/ppv-lite86/0.2.15 \
> -    crate://crates.io/proptest/1.0.0 \
> -    crate://crates.io/quick-error/1.2.3 \
> -    crate://crates.io/quick-error/2.0.1 \
> -    crate://crates.io/rand/0.8.4 \
> -    crate://crates.io/rand_chacha/0.3.1 \
> -    crate://crates.io/rand_core/0.6.3 \
> -    crate://crates.io/rand_hc/0.3.1 \
> -    crate://crates.io/rand_xorshift/0.3.0 \
> -    crate://crates.io/redox_syscall/0.2.10 \
> -    crate://crates.io/regex-syntax/0.6.25 \
> -    crate://crates.io/remove_dir_all/0.5.3 \
> -    crate://crates.io/rusty-fork/0.3.0 \
> -    crate://crates.io/tempfile/3.2.0 \
> -    crate://crates.io/wait-timeout/0.2.0 \
> -    crate://crates.io/wasi/0.10.2+wasi-snapshot-preview1 \
> -    crate://crates.io/winapi/0.3.9 \
> -    crate://crates.io/winapi-i686-pc-windows-gnu/0.4.0 \
> -    crate://crates.io/winapi-x86_64-pc-windows-gnu/0.4.0 \
> -"
> -
> -SRC_URI[autocfg-1.0.1.sha256sum] = "cdb031dd78e28731d87d56cc8ffef4a8f36ca26c38fe2de700543e627f8a464a"
> -SRC_URI[bit-set-0.5.2.sha256sum] = "6e11e16035ea35e4e5997b393eacbf6f63983188f7a2ad25bfb13465f5ad59de"
> -SRC_URI[bit-vec-0.6.3.sha256sum] = "349f9b6a179ed607305526ca489b34ad0a41aed5f7980fa90eb03160b69598fb"
> -SRC_URI[bitflags-1.3.2.sha256sum] = "bef38d45163c2f1dde094a7dfd33ccf595c92905c8f8f4fdc18d06fb1037718a"
> -SRC_URI[byteorder-1.4.3.sha256sum] = "14c189c53d098945499cdfa7ecc63567cf3886b3332b312a5b4585d8d3a6a610"
> -SRC_URI[cfg-if-1.0.0.sha256sum] = "baf1de4339761588bc0619e3cbc0120ee582ebb74b53b4efbf79117bd2da40fd"
> -SRC_URI[doc-comment-0.3.3.sha256sum] = "fea41bba32d969b513997752735605054bc0dfa92b4c56bf1189f2e174be7a10"
> -SRC_URI[fnv-1.0.7.sha256sum] = "3f9eec918d3f24069decb9af1554cad7c880e2da24a9afd88aca000531ab82c1"
> -SRC_URI[getrandom-0.2.3.sha256sum] = "7fcd999463524c52659517fe2cea98493cfe485d10565e7b0fb07dbba7ad2753"
> -SRC_URI[lazy_static-1.4.0.sha256sum] = "e2abad23fbc42b3700f2f279844dc832adb2b2eb069b2df918f455c4e18cc646"
> -SRC_URI[libc-0.2.106.sha256sum] = "a60553f9a9e039a333b4e9b20573b9e9b9c0bb3a11e201ccc48ef4283456d673"
> -SRC_URI[memchr-2.4.1.sha256sum] = "308cc39be01b73d0d18f82a0e7b2a3df85245f84af96fdddc5d202d27e47b86a"
> -SRC_URI[minimal-lexical-0.2.1.sha256sum] = "68354c5c6bd36d73ff3feceb05efa59b6acb7626617f4962be322a825e61f79a"
> -SRC_URI[num-traits-0.2.14.sha256sum] = "9a64b1ec5cda2586e284722486d802acf1f7dbdc623e2bfc57e65ca1cd099290"
> -SRC_URI[ppv-lite86-0.2.15.sha256sum] = "ed0cfbc8191465bed66e1718596ee0b0b35d5ee1f41c5df2189d0fe8bde535ba"
> -SRC_URI[proptest-1.0.0.sha256sum] = "1e0d9cc07f18492d879586c92b485def06bc850da3118075cd45d50e9c95b0e5"
> -SRC_URI[quick-error-1.2.3.sha256sum] = "a1d01941d82fa2ab50be1e79e6714289dd7cde78eba4c074bc5a4374f650dfe0"
> -SRC_URI[quick-error-2.0.1.sha256sum] = "a993555f31e5a609f617c12db6250dedcac1b0a85076912c436e6fc9b2c8e6a3"
> -SRC_URI[rand-0.8.4.sha256sum] = "2e7573632e6454cf6b99d7aac4ccca54be06da05aca2ef7423d22d27d4d4bcd8"
> -SRC_URI[rand_chacha-0.3.1.sha256sum] = "e6c10a63a0fa32252be49d21e7709d4d4baf8d231c2dbce1eaa8141b9b127d88"
> -SRC_URI[rand_core-0.6.3.sha256sum] = "d34f1408f55294453790c48b2f1ebbb1c5b4b7563eb1f418bcfcfdbb06ebb4e7"
> -SRC_URI[rand_hc-0.3.1.sha256sum] = "d51e9f596de227fda2ea6c84607f5558e196eeaf43c986b724ba4fb8fdf497e7"
> -SRC_URI[rand_xorshift-0.3.0.sha256sum] = "d25bf25ec5ae4a3f1b92f929810509a2f53d7dca2f50b794ff57e3face536c8f"
> -SRC_URI[redox_syscall-0.2.10.sha256sum] = "8383f39639269cde97d255a32bdb68c047337295414940c68bdd30c2e13203ff"
> -SRC_URI[regex-syntax-0.6.25.sha256sum] = "f497285884f3fcff424ffc933e56d7cbca511def0c9831a7f9b5f6153e3cc89b"
> -SRC_URI[remove_dir_all-0.5.3.sha256sum] = "3acd125665422973a33ac9d3dd2df85edad0f4ae9b00dafb1a05e43a9f5ef8e7"
> -SRC_URI[rusty-fork-0.3.0.sha256sum] = "cb3dcc6e454c328bb824492db107ab7c0ae8fcffe4ad210136ef014458c1bc4f"
> -SRC_URI[tempfile-3.2.0.sha256sum] = "dac1c663cfc93810f88aed9b8941d48cabf856a1b111c29a40439018d870eb22"
> -SRC_URI[wait-timeout-0.2.0.sha256sum] = "9f200f5b12eb75f8c1ed65abd4b2db8a6e1b138a20de009dacee265a2498f3f6"
> -SRC_URI[wasi-0.10.2+wasi-snapshot-preview1.sha256sum] = "fd6fbd9a79829dd1ad0cc20627bf1ed606756a7f77edff7b66b7064f9cb327c6"
> -SRC_URI[winapi-0.3.9.sha256sum] = "5c839a674fcd7a98952e593242ea400abe93992746761e38641405d28b00f419"
> -SRC_URI[winapi-i686-pc-windows-gnu-0.4.0.sha256sum] = "ac3b87c63620426dd9b991e5ce0329eff545bccbbb34f3be09ff6fb6ab51b7b6"
> -SRC_URI[winapi-x86_64-pc-windows-gnu-0.4.0.sha256sum] = "712e227841d057c1ee1cd2fb22fa7e5a5461ae8e48fa2ca79ec42cfc1931183f"
>  # from rust/vendor/brotli/Cargo.lock
> -SRC_URI += " \
> -    crate://crates.io/alloc-no-stdlib/2.0.3 \
> -    crate://crates.io/alloc-stdlib/0.2.1 \
> -    crate://crates.io/block-buffer/0.7.3 \
> -    crate://crates.io/block-padding/0.1.5 \
> -    crate://crates.io/brotli-decompressor/2.3.2 \
> -    crate://crates.io/byte-tools/0.3.1 \
> -    crate://crates.io/byteorder/1.4.3 \
> -    crate://crates.io/cfg-if/1.0.0 \
> -    crate://crates.io/digest/0.8.1 \
> -    crate://crates.io/fake-simd/0.1.2 \
> -    crate://crates.io/generic-array/0.12.4 \
> -    crate://crates.io/libm/0.1.4 \
> -    crate://crates.io/opaque-debug/0.2.3 \
> -    crate://crates.io/packed_simd_2/0.3.7 \
> -    crate://crates.io/sha2/0.8.2 \
> -    crate://crates.io/typenum/1.15.0 \
> -"
> -
> -SRC_URI[alloc-no-stdlib-2.0.3.sha256sum] = "35ef4730490ad1c4eae5c4325b2a95f521d023e5c885853ff7aca0a6a1631db3"
> -SRC_URI[alloc-stdlib-0.2.1.sha256sum] = "697ed7edc0f1711de49ce108c541623a0af97c6c60b2f6e2b65229847ac843c2"
> -SRC_URI[block-buffer-0.7.3.sha256sum] = "c0940dc441f31689269e10ac70eb1002a3a1d3ad1390e030043662eb7fe4688b"
> -SRC_URI[block-padding-0.1.5.sha256sum] = "fa79dedbb091f449f1f39e53edf88d5dbe95f895dae6135a8d7b881fb5af73f5"
> -SRC_URI[brotli-decompressor-2.3.2.sha256sum] = "59ad2d4653bf5ca36ae797b1f4bb4dbddb60ce49ca4aed8a2ce4829f60425b80"
> -SRC_URI[byte-tools-0.3.1.sha256sum] = "e3b5ca7a04898ad4bcd41c90c5285445ff5b791899bb1b0abdd2a2aa791211d7"
> -SRC_URI[byteorder-1.4.3.sha256sum] = "14c189c53d098945499cdfa7ecc63567cf3886b3332b312a5b4585d8d3a6a610"
> -SRC_URI[cfg-if-1.0.0.sha256sum] = "baf1de4339761588bc0619e3cbc0120ee582ebb74b53b4efbf79117bd2da40fd"
> -SRC_URI[digest-0.8.1.sha256sum] = "f3d0c8c8752312f9713efd397ff63acb9f85585afbf179282e720e7704954dd5"
> -SRC_URI[fake-simd-0.1.2.sha256sum] = "e88a8acf291dafb59c2d96e8f59828f3838bb1a70398823ade51a84de6a6deed"
> -SRC_URI[generic-array-0.12.4.sha256sum] = "ffdf9f34f1447443d37393cc6c2b8313aebddcd96906caf34e54c68d8e57d7bd"
> -SRC_URI[libm-0.1.4.sha256sum] = "7fc7aa29613bd6a620df431842069224d8bc9011086b1db4c0e0cd47fa03ec9a"
> -SRC_URI[opaque-debug-0.2.3.sha256sum] = "2839e79665f131bdb5782e51f2c6c9599c133c6098982a54c794358bf432529c"
> -SRC_URI[packed_simd_2-0.3.7.sha256sum] = "defdcfef86dcc44ad208f71d9ff4ce28df6537a4e0d6b0e8e845cb8ca10059a6"
> -SRC_URI[sha2-0.8.2.sha256sum] = "a256f46ea78a0c0d9ff00077504903ac881a1dafdc20da66545699e7776b3e69"
> -SRC_URI[typenum-1.15.0.sha256sum] = "dcf81ac59edc17cc8697ff311e8f5ef2d99fcbd9817b34cec66f90b6c3dfd987"
> -# from rust/vendor/failure/Cargo.lock
> -SRC_URI += " \
> -    crate://crates.io/backtrace/0.3.46 \
> -    crate://crates.io/backtrace-sys/0.1.37 \
> -    crate://crates.io/cc/1.0.52 \
> -    crate://crates.io/cfg-if/0.1.10 \
> -    crate://crates.io/failure_derive/0.1.7 \
> -    crate://crates.io/libc/0.2.69 \
> -    crate://crates.io/proc-macro2/1.0.12 \
> -    crate://crates.io/quote/1.0.4 \
> -    crate://crates.io/rustc-demangle/0.1.16 \
> -    crate://crates.io/syn/1.0.18 \
> -    crate://crates.io/synstructure/0.12.3 \
> -    crate://crates.io/unicode-xid/0.2.0 \
> -"
> -
> -SRC_URI[backtrace-0.3.46.sha256sum] = "b1e692897359247cc6bb902933361652380af0f1b7651ae5c5013407f30e109e"
> -SRC_URI[backtrace-sys-0.1.37.sha256sum] = "18fbebbe1c9d1f383a9cc7e8ccdb471b91c8d024ee9c2ca5b5346121fe8b4399"
> -SRC_URI[cc-1.0.52.sha256sum] = "c3d87b23d6a92cd03af510a5ade527033f6aa6fa92161e2d5863a907d4c5e31d"
> -SRC_URI[cfg-if-0.1.10.sha256sum] = "4785bdd1c96b2a846b2bd7cc02e86b6b3dbf14e7e53446c4f54c92a361040822"
> -SRC_URI[failure_derive-0.1.7.sha256sum] = "030a733c8287d6213886dd487564ff5c8f6aae10278b3588ed177f9d18f8d231"
> -SRC_URI[libc-0.2.69.sha256sum] = "99e85c08494b21a9054e7fe1374a732aeadaff3980b6990b94bfd3a70f690005"
> -SRC_URI[proc-macro2-1.0.12.sha256sum] = "8872cf6f48eee44265156c111456a700ab3483686b3f96df4cf5481c89157319"
> -SRC_URI[quote-1.0.4.sha256sum] = "4c1f4b0efa5fc5e8ceb705136bfee52cfdb6a4e3509f770b478cd6ed434232a7"
> -SRC_URI[rustc-demangle-0.1.16.sha256sum] = "4c691c0e608126e00913e33f0ccf3727d5fc84573623b8d65b2df340b5201783"
> -SRC_URI[syn-1.0.18.sha256sum] = "410a7488c0a728c7ceb4ad59b9567eb4053d02e8cc7f5c0e0eeeb39518369213"
> -SRC_URI[synstructure-0.12.3.sha256sum] = "67656ea1dc1b41b1451851562ea232ec2e5a80242139f7e679ceccfb5d61f545"
> -SRC_URI[unicode-xid-0.2.0.sha256sum] = "826e7639553986605ec5979c7dd957c7895e93eabed50ab2ffa7f6128a75097c"
> -# from rust/vendor/alloc-stdlib/Cargo.lock
> -SRC_URI += " \
> -    crate://crates.io/alloc-no-stdlib/2.0.4 \
> -"
> -
> -SRC_URI[alloc-no-stdlib-2.0.4.sha256sum] = "cc7bb162ec39d46ab1ca8c77bf72e890535becd1751bb45f64c597edb4c8c6b3"
> -# from rust/vendor/bendy/Cargo.lock
> -SRC_URI += " \
> -    crate://crates.io/addr2line/0.14.0 \
> -    crate://crates.io/adler/0.2.3 \
> -    crate://crates.io/aho-corasick/0.7.15 \
> -    crate://crates.io/autocfg/1.0.1 \
> -    crate://crates.io/backtrace/0.3.54 \
> -    crate://crates.io/cfg-if/1.0.0 \
> -    crate://crates.io/failure/0.1.8 \
> -    crate://crates.io/failure_derive/0.1.8 \
> -    crate://crates.io/gimli/0.23.0 \
> -    crate://crates.io/lazy_static/1.4.0 \
> -    crate://crates.io/libc/0.2.80 \
> -    crate://crates.io/memchr/2.3.4 \
> -    crate://crates.io/miniz_oxide/0.4.3 \
> -    crate://crates.io/object/0.22.0 \
> -    crate://crates.io/proc-macro2/1.0.24 \
> -    crate://crates.io/quote/1.0.7 \
> -    crate://crates.io/regex/1.4.2 \
> -    crate://crates.io/regex-syntax/0.6.21 \
> -    crate://crates.io/rustc-demangle/0.1.18 \
> -    crate://crates.io/serde/1.0.117 \
> -    crate://crates.io/serde_bytes/0.11.5 \
> -    crate://crates.io/serde_derive/1.0.117 \
> -    crate://crates.io/syn/1.0.48 \
> -    crate://crates.io/synstructure/0.12.4 \
> -    crate://crates.io/thread_local/1.0.1 \
> -    crate://crates.io/unicode-xid/0.2.1 \
> -"
> -
> -SRC_URI[addr2line-0.14.0.sha256sum] = "7c0929d69e78dd9bf5408269919fcbcaeb2e35e5d43e5815517cdc6a8e11a423"
> -SRC_URI[adler-0.2.3.sha256sum] = "ee2a4ec343196209d6594e19543ae87a39f96d5534d7174822a3ad825dd6ed7e"
> -SRC_URI[aho-corasick-0.7.15.sha256sum] = "7404febffaa47dac81aa44dba71523c9d069b1bdc50a77db41195149e17f68e5"
> -SRC_URI[autocfg-1.0.1.sha256sum] = "cdb031dd78e28731d87d56cc8ffef4a8f36ca26c38fe2de700543e627f8a464a"
> -SRC_URI[backtrace-0.3.54.sha256sum] = "2baad346b2d4e94a24347adeee9c7a93f412ee94b9cc26e5b59dea23848e9f28"
> -SRC_URI[cfg-if-1.0.0.sha256sum] = "baf1de4339761588bc0619e3cbc0120ee582ebb74b53b4efbf79117bd2da40fd"
> -SRC_URI[failure-0.1.8.sha256sum] = "d32e9bd16cc02eae7db7ef620b392808b89f6a5e16bb3497d159c6b92a0f4f86"
> -SRC_URI[failure_derive-0.1.8.sha256sum] = "aa4da3c766cd7a0db8242e326e9e4e081edd567072893ed320008189715366a4"
> -SRC_URI[gimli-0.23.0.sha256sum] = "f6503fe142514ca4799d4c26297c4248239fe8838d827db6bd6065c6ed29a6ce"
> -SRC_URI[lazy_static-1.4.0.sha256sum] = "e2abad23fbc42b3700f2f279844dc832adb2b2eb069b2df918f455c4e18cc646"
> -SRC_URI[libc-0.2.80.sha256sum] = "4d58d1b70b004888f764dfbf6a26a3b0342a1632d33968e4a179d8011c760614"
> -SRC_URI[memchr-2.3.4.sha256sum] = "0ee1c47aaa256ecabcaea351eae4a9b01ef39ed810004e298d2511ed284b1525"
> -SRC_URI[miniz_oxide-0.4.3.sha256sum] = "0f2d26ec3309788e423cfbf68ad1800f061638098d76a83681af979dc4eda19d"
> -SRC_URI[object-0.22.0.sha256sum] = "8d3b63360ec3cb337817c2dbd47ab4a0f170d285d8e5a2064600f3def1402397"
> -SRC_URI[proc-macro2-1.0.24.sha256sum] = "1e0704ee1a7e00d7bb417d0770ea303c1bccbabf0ef1667dae92b5967f5f8a71"
> -SRC_URI[quote-1.0.7.sha256sum] = "aa563d17ecb180e500da1cfd2b028310ac758de548efdd203e18f283af693f37"
> -SRC_URI[regex-1.4.2.sha256sum] = "38cf2c13ed4745de91a5eb834e11c00bcc3709e773173b2ce4c56c9fbde04b9c"
> -SRC_URI[regex-syntax-0.6.21.sha256sum] = "3b181ba2dcf07aaccad5448e8ead58db5b742cf85dfe035e2227f137a539a189"
> -SRC_URI[rustc-demangle-0.1.18.sha256sum] = "6e3bad0ee36814ca07d7968269dd4b7ec89ec2da10c4bb613928d3077083c232"
> -SRC_URI[serde-1.0.117.sha256sum] = "b88fa983de7720629c9387e9f517353ed404164b1e482c970a90c1a4aaf7dc1a"
> -SRC_URI[serde_bytes-0.11.5.sha256sum] = "16ae07dd2f88a366f15bd0632ba725227018c69a1c8550a927324f8eb8368bb9"
> -SRC_URI[serde_derive-1.0.117.sha256sum] = "cbd1ae72adb44aab48f325a02444a5fc079349a8d804c1fc922aed3f7454c74e"
> -SRC_URI[syn-1.0.48.sha256sum] = "cc371affeffc477f42a221a1e4297aedcea33d47d19b61455588bd9d8f6b19ac"
> -SRC_URI[synstructure-0.12.4.sha256sum] = "b834f2d66f734cb897113e34aaff2f1ab4719ca946f9a7358dba8f8064148701"
> -SRC_URI[thread_local-1.0.1.sha256sum] = "d40c6d1b69745a6ec6fb1ca717914848da4b44ae29d9b3080cbee91d72a69b14"
> -SRC_URI[unicode-xid-0.2.1.sha256sum] = "f7fe0bb3479651439c9112f72b6c505038574c9fbb575ed1bf3b797fa39dd564"
> -# from rust/vendor/regex/Cargo.lock
> -SRC_URI += " \
> -    crate://crates.io/aho-corasick/0.7.18 \
> -    crate://crates.io/cfg-if/1.0.0 \
> -    crate://crates.io/getrandom/0.2.6 \
> -    crate://crates.io/lazy_static/1.4.0 \
> -    crate://crates.io/libc/0.2.125 \
> -    crate://crates.io/memchr/2.5.0 \
> -    crate://crates.io/quickcheck/1.0.3 \
> -    crate://crates.io/rand/0.8.5 \
> -    crate://crates.io/rand_core/0.6.3 \
> -    crate://crates.io/regex-syntax/0.6.26 \
> -    crate://crates.io/wasi/0.10.2+wasi-snapshot-preview1 \
> -"
> -
> -SRC_URI[aho-corasick-0.7.18.sha256sum] = "1e37cfd5e7657ada45f742d6e99ca5788580b5c529dc78faf11ece6dc702656f"
> -SRC_URI[cfg-if-1.0.0.sha256sum] = "baf1de4339761588bc0619e3cbc0120ee582ebb74b53b4efbf79117bd2da40fd"
> -SRC_URI[getrandom-0.2.6.sha256sum] = "9be70c98951c83b8d2f8f60d7065fa6d5146873094452a1008da8c2f1e4205ad"
> -SRC_URI[lazy_static-1.4.0.sha256sum] = "e2abad23fbc42b3700f2f279844dc832adb2b2eb069b2df918f455c4e18cc646"
> -SRC_URI[libc-0.2.125.sha256sum] = "5916d2ae698f6de9bfb891ad7a8d65c09d232dc58cc4ac433c7da3b2fd84bc2b"
> -SRC_URI[memchr-2.5.0.sha256sum] = "2dffe52ecf27772e601905b7522cb4ef790d2cc203488bbd0e2fe85fcb74566d"
> -SRC_URI[quickcheck-1.0.3.sha256sum] = "588f6378e4dd99458b60ec275b4477add41ce4fa9f64dcba6f15adccb19b50d6"
> -SRC_URI[rand-0.8.5.sha256sum] = "34af8d1a0e25924bc5b7c43c079c942339d8f0a8b57c39049bef581b46327404"
> -SRC_URI[rand_core-0.6.3.sha256sum] = "d34f1408f55294453790c48b2f1ebbb1c5b4b7563eb1f418bcfcfdbb06ebb4e7"
> -SRC_URI[regex-syntax-0.6.26.sha256sum] = "49b3de9ec5dc0a3417da371aab17d729997c15010e7fd24ff707773a33bddb64"
> -SRC_URI[wasi-0.10.2+wasi-snapshot-preview1.sha256sum] = "fd6fbd9a79829dd1ad0cc20627bf1ed606756a7f77edff7b66b7064f9cb327c6"
> -# from rust/vendor/brotli-decompressor/Cargo.lock
> -SRC_URI += " \
> -    crate://crates.io/alloc-no-stdlib/2.0.4 \
> -    crate://crates.io/alloc-stdlib/0.2.2 \
> -"
>
>  SRC_URI[alloc-no-stdlib-2.0.4.sha256sum] = "cc7bb162ec39d46ab1ca8c77bf72e890535becd1751bb45f64c597edb4c8c6b3"
>  SRC_URI[alloc-stdlib-0.2.2.sha256sum] = "94fb8275041c72129eb51b7d0322c29b8387a0386127718b096429201a5d6ece"
> +SRC_URI[block-buffer-0.10.4.sha256sum] = "3078c7629b62d3f0439517fa394996acacc5cbc91c5a20d8c658e77abd503a71"
> +SRC_URI[brotli-decompressor-5.0.0.sha256sum] = "874bb8112abecc98cbd6d81ea4fa7e94fb9449648c93cc89aa40c81c24d7de03"
> +SRC_URI[cfg-if-1.0.0.sha256sum] = "baf1de4339761588bc0619e3cbc0120ee582ebb74b53b4efbf79117bd2da40fd"
> +SRC_URI[cpufeatures-0.2.17.sha256sum] = "59ed5838eebb26a2bb2e58f6d5b5316989ae9d08bab10e0e6d103e656d1b0280"
> +SRC_URI[crypto-common-0.1.6.sha256sum] = "1bfb12502f3fc46cca1bb51ac28df9d618d813cdc3d2f25b9fe775a34af26bb3"
> +SRC_URI[digest-0.10.7.sha256sum] = "9ed9a281f7bc9b7576e61468ba615a66a5c8cfdff42420a70aa82701a3b1e292"
> +SRC_URI[generic-array-0.14.7.sha256sum] = "85649ca51fd72272d7821adaf274ad91c288277713d9c18820d8499a7ff69e9a"
> +SRC_URI[libc-0.2.172.sha256sum] = "d750af042f7ef4f724306de029d18836c26c1765a54a6a3f094cbd23a7267ffa"
> +SRC_URI[sha2-0.10.9.sha256sum] = "a7507d819769d01a365ab707794a4084392c824f54a7a6a7862f8c3d0892b283"
> +SRC_URI[typenum-1.18.0.sha256sum] = "1dccffe3ce07af9386bfd29e80c0ab1a8205a2fc34e4bcd40364df902cfa8f3f"
> +SRC_URI[version_check-0.9.5.sha256sum] = "0b928f33d975fc6ad9f86c8f283853ad26bdd5b10b7f1542aa2fa15e2289105a"
>  # from rust/vendor/phf_generator/Cargo.lock
> -SRC_URI += " \
> -    crate://crates.io/atty/0.2.14 \
> -    crate://crates.io/autocfg/1.0.1 \
> -    crate://crates.io/bitflags/1.2.1 \
> -    crate://crates.io/bstr/0.2.16 \
> -    crate://crates.io/bumpalo/3.7.0 \
> -    crate://crates.io/cast/0.2.7 \
> -    crate://crates.io/cfg-if/1.0.0 \
> -    crate://crates.io/clap/2.33.3 \
> -    crate://crates.io/criterion/0.3.4 \
> -    crate://crates.io/criterion-plot/0.4.4 \
> -    crate://crates.io/crossbeam-channel/0.5.1 \
> -    crate://crates.io/crossbeam-deque/0.8.1 \
> -    crate://crates.io/crossbeam-epoch/0.9.5 \
> -    crate://crates.io/crossbeam-utils/0.8.5 \
> -    crate://crates.io/csv/1.1.6 \
> -    crate://crates.io/csv-core/0.1.10 \
> -    crate://crates.io/either/1.6.1 \
> -    crate://crates.io/getrandom/0.2.3 \
> -    crate://crates.io/half/1.7.1 \
> -    crate://crates.io/hermit-abi/0.1.19 \
> -    crate://crates.io/itertools/0.10.1 \
> -    crate://crates.io/itoa/0.4.7 \
> -    crate://crates.io/js-sys/0.3.52 \
> -    crate://crates.io/lazy_static/1.4.0 \
> -    crate://crates.io/libc/0.2.99 \
> -    crate://crates.io/log/0.4.14 \
> -    crate://crates.io/memchr/2.4.0 \
> -    crate://crates.io/memoffset/0.6.4 \
> -    crate://crates.io/num-traits/0.2.14 \
> -    crate://crates.io/num_cpus/1.13.0 \
> -    crate://crates.io/oorandom/11.1.3 \
> -    crate://crates.io/phf_shared/0.10.0 \
> -    crate://crates.io/plotters/0.3.1 \
> -    crate://crates.io/plotters-backend/0.3.2 \
> -    crate://crates.io/plotters-svg/0.3.1 \
> -    crate://crates.io/ppv-lite86/0.2.10 \
> -    crate://crates.io/proc-macro2/1.0.28 \
> -    crate://crates.io/quote/1.0.9 \
> -    crate://crates.io/rand/0.8.4 \
> -    crate://crates.io/rand_chacha/0.3.1 \
> -    crate://crates.io/rand_core/0.6.3 \
> -    crate://crates.io/rand_hc/0.3.1 \
> -    crate://crates.io/rayon/1.5.1 \
> -    crate://crates.io/rayon-core/1.9.1 \
> -    crate://crates.io/regex/1.5.4 \
> -    crate://crates.io/regex-automata/0.1.10 \
> -    crate://crates.io/regex-syntax/0.6.25 \
> -    crate://crates.io/rustc_version/0.4.0 \
> -    crate://crates.io/ryu/1.0.5 \
> -    crate://crates.io/same-file/1.0.6 \
> -    crate://crates.io/scopeguard/1.1.0 \
> -    crate://crates.io/semver/1.0.4 \
> -    crate://crates.io/serde/1.0.127 \
> -    crate://crates.io/serde_cbor/0.11.1 \
> -    crate://crates.io/serde_derive/1.0.127 \
> -    crate://crates.io/serde_json/1.0.66 \
> -    crate://crates.io/siphasher/0.3.6 \
> -    crate://crates.io/syn/1.0.74 \
> -    crate://crates.io/textwrap/0.11.0 \
> -    crate://crates.io/tinytemplate/1.2.1 \
> -    crate://crates.io/unicode-width/0.1.8 \
> -    crate://crates.io/unicode-xid/0.2.2 \
> -    crate://crates.io/walkdir/2.3.2 \
> -    crate://crates.io/wasi/0.10.2+wasi-snapshot-preview1 \
> -    crate://crates.io/wasm-bindgen/0.2.75 \
> -    crate://crates.io/wasm-bindgen-backend/0.2.75 \
> -    crate://crates.io/wasm-bindgen-macro/0.2.75 \
> -    crate://crates.io/wasm-bindgen-macro-support/0.2.75 \
> -    crate://crates.io/wasm-bindgen-shared/0.2.75 \
> -    crate://crates.io/web-sys/0.3.52 \
> -    crate://crates.io/winapi/0.3.9 \
> -    crate://crates.io/winapi-i686-pc-windows-gnu/0.4.0 \
> -    crate://crates.io/winapi-util/0.1.5 \
> -    crate://crates.io/winapi-x86_64-pc-windows-gnu/0.4.0 \
> -"
>
>  SRC_URI[atty-0.2.14.sha256sum] = "d9b39be18770d11421cdb1b9947a45dd3f37e93092cbf377614828a319d5fee8"
>  SRC_URI[autocfg-1.0.1.sha256sum] = "cdb031dd78e28731d87d56cc8ffef4a8f36ca26c38fe2de700543e627f8a464a"
> @@ -1048,103 +994,120 @@ SRC_URI[winapi-0.3.9.sha256sum] = "5c839a674fcd7a98952e593242ea400abe93992746761
>  SRC_URI[winapi-i686-pc-windows-gnu-0.4.0.sha256sum] = "ac3b87c63620426dd9b991e5ce0329eff545bccbbb34f3be09ff6fb6ab51b7b6"
>  SRC_URI[winapi-util-0.1.5.sha256sum] = "70ec6ce85bb158151cae5e5c87f95a8e97d2c0c4b001223f33a334e3ce5de178"
>  SRC_URI[winapi-x86_64-pc-windows-gnu-0.4.0.sha256sum] = "712e227841d057c1ee1cd2fb22fa7e5a5461ae8e48fa2ca79ec42cfc1931183f"
> +# from rust/vendor/alloc-stdlib/Cargo.lock
> +
> +SRC_URI[alloc-no-stdlib-2.0.4.sha256sum] = "cc7bb162ec39d46ab1ca8c77bf72e890535becd1751bb45f64c597edb4c8c6b3"
>  # from rust/vendor/x509-parser/Cargo.lock
> -SRC_URI += " \
> -    crate://crates.io/asn1-rs/0.5.2 \
> -    crate://crates.io/asn1-rs-derive/0.4.0 \
> -    crate://crates.io/asn1-rs-impl/0.1.0 \
> -    crate://crates.io/autocfg/1.1.0 \
> -    crate://crates.io/bumpalo/3.12.0 \
> -    crate://crates.io/cc/1.0.79 \
> -    crate://crates.io/cfg-if/1.0.0 \
> -    crate://crates.io/data-encoding/2.3.3 \
> -    crate://crates.io/der-parser/8.2.0 \
> -    crate://crates.io/displaydoc/0.2.3 \
> -    crate://crates.io/itoa/1.0.6 \
> -    crate://crates.io/js-sys/0.3.61 \
> -    crate://crates.io/lazy_static/1.4.0 \
> -    crate://crates.io/libc/0.2.140 \
> -    crate://crates.io/log/0.4.17 \
> -    crate://crates.io/memchr/2.5.0 \
> -    crate://crates.io/minimal-lexical/0.2.1 \
> -    crate://crates.io/nom/7.1.3 \
> -    crate://crates.io/num-bigint/0.4.3 \
> -    crate://crates.io/num-integer/0.1.45 \
> -    crate://crates.io/num-traits/0.2.15 \
> -    crate://crates.io/oid-registry/0.6.1 \
> -    crate://crates.io/once_cell/1.17.1 \
> -    crate://crates.io/proc-macro2/1.0.52 \
> -    crate://crates.io/quote/1.0.26 \
> -    crate://crates.io/ring/0.16.20 \
> -    crate://crates.io/rusticata-macros/4.1.0 \
> -    crate://crates.io/serde/1.0.156 \
> -    crate://crates.io/spin/0.5.2 \
> -    crate://crates.io/syn/1.0.109 \
> -    crate://crates.io/synstructure/0.12.6 \
> -    crate://crates.io/thiserror/1.0.39 \
> -    crate://crates.io/thiserror-impl/1.0.39 \
> -    crate://crates.io/time/0.3.20 \
> -    crate://crates.io/time-core/0.1.0 \
> -    crate://crates.io/time-macros/0.2.8 \
> -    crate://crates.io/unicode-ident/1.0.8 \
> -    crate://crates.io/unicode-xid/0.2.4 \
> -    crate://crates.io/untrusted/0.7.1 \
> -    crate://crates.io/wasm-bindgen/0.2.84 \
> -    crate://crates.io/wasm-bindgen-backend/0.2.84 \
> -    crate://crates.io/wasm-bindgen-macro/0.2.84 \
> -    crate://crates.io/wasm-bindgen-macro-support/0.2.84 \
> -    crate://crates.io/wasm-bindgen-shared/0.2.84 \
> -    crate://crates.io/web-sys/0.3.61 \
> -    crate://crates.io/winapi/0.3.9 \
> -    crate://crates.io/winapi-i686-pc-windows-gnu/0.4.0 \
> -    crate://crates.io/winapi-x86_64-pc-windows-gnu/0.4.0 \
> -"
>
>  SRC_URI[asn1-rs-0.5.2.sha256sum] = "7f6fd5ddaf0351dff5b8da21b2fb4ff8e08ddd02857f0bf69c47639106c0fff0"
>  SRC_URI[asn1-rs-derive-0.4.0.sha256sum] = "726535892e8eae7e70657b4c8ea93d26b8553afb1ce617caee529ef96d7dee6c"
>  SRC_URI[asn1-rs-impl-0.1.0.sha256sum] = "2777730b2039ac0f95f093556e61b6d26cebed5393ca6f152717777cec3a42ed"
>  SRC_URI[autocfg-1.1.0.sha256sum] = "d468802bab17cbc0cc575e9b053f41e72aa36bfa6b7f55e3529ffa43161b97fa"
> -SRC_URI[bumpalo-3.12.0.sha256sum] = "0d261e256854913907f67ed06efbc3338dfe6179796deefc1ff763fc1aee5535"
> -SRC_URI[cc-1.0.79.sha256sum] = "50d30906286121d95be3d479533b458f87493b30a4b5f79a607db8f5d11aa91f"
> +SRC_URI[bumpalo-3.13.0.sha256sum] = "a3e2c3daef883ecc1b5d58c15adae93470a91d425f3532ba1695849656af3fc1"
> +SRC_URI[cc-1.0.81.sha256sum] = "6c6b2562119bf28c3439f7f02db99faf0aa1a8cdfe5772a2ee155d32227239f0"
>  SRC_URI[cfg-if-1.0.0.sha256sum] = "baf1de4339761588bc0619e3cbc0120ee582ebb74b53b4efbf79117bd2da40fd"
> -SRC_URI[data-encoding-2.3.3.sha256sum] = "23d8666cb01533c39dde32bcbab8e227b4ed6679b2c925eba05feabea39508fb"
> +SRC_URI[data-encoding-2.4.0.sha256sum] = "c2e66c9d817f1720209181c316d28635c050fa304f9c79e47a520882661b7308"
>  SRC_URI[der-parser-8.2.0.sha256sum] = "dbd676fbbab537128ef0278adb5576cf363cff6aa22a7b24effe97347cfab61e"
> -SRC_URI[displaydoc-0.2.3.sha256sum] = "3bf95dc3f046b9da4f2d51833c0d3547d8564ef6910f5c1ed130306a75b92886"
> -SRC_URI[itoa-1.0.6.sha256sum] = "453ad9f582a441959e5f0d088b02ce04cfe8d51a8eaf077f12ac6d3e94164ca6"
> -SRC_URI[js-sys-0.3.61.sha256sum] = "445dde2150c55e483f3d8416706b97ec8e8237c307e5b7b4b8dd15e6af2a0730"
> +SRC_URI[deranged-0.3.7.sha256sum] = "7684a49fb1af197853ef7b2ee694bc1f5b4179556f1e5710e1760c5db6f5e929"
> +SRC_URI[displaydoc-0.2.4.sha256sum] = "487585f4d0c6655fe74905e2504d8ad6908e4db67f744eb140876906c2f3175d"
> +SRC_URI[itoa-1.0.9.sha256sum] = "af150ab688ff2122fcef229be89cb50dd66af9e01a4ff320cc137eecc9bacc38"
> +SRC_URI[js-sys-0.3.64.sha256sum] = "c5f195fe497f702db0f318b07fdd68edb16955aed830df8363d837542f8f935a"
>  SRC_URI[lazy_static-1.4.0.sha256sum] = "e2abad23fbc42b3700f2f279844dc832adb2b2eb069b2df918f455c4e18cc646"
> -SRC_URI[libc-0.2.140.sha256sum] = "99227334921fae1a979cf0bfdfcc6b3e5ce376ef57e16fb6fb3ea2ed6095f80c"
> -SRC_URI[log-0.4.17.sha256sum] = "abb12e687cfb44aa40f41fc3978ef76448f9b6038cad6aef4259d3c095a2382e"
> +SRC_URI[libc-0.2.147.sha256sum] = "b4668fb0ea861c1df094127ac5f1da3409a82116a4ba74fca2e58ef927159bb3"
> +SRC_URI[log-0.4.19.sha256sum] = "b06a4cde4c0f271a446782e3eff8de789548ce57dbc8eca9292c27f4a42004b4"
>  SRC_URI[memchr-2.5.0.sha256sum] = "2dffe52ecf27772e601905b7522cb4ef790d2cc203488bbd0e2fe85fcb74566d"
>  SRC_URI[minimal-lexical-0.2.1.sha256sum] = "68354c5c6bd36d73ff3feceb05efa59b6acb7626617f4962be322a825e61f79a"
>  SRC_URI[nom-7.1.3.sha256sum] = "d273983c5a657a70a3e8f2a01329822f3b8c8172b73826411a55751e404a0a4a"
>  SRC_URI[num-bigint-0.4.3.sha256sum] = "f93ab6289c7b344a8a9f60f88d80aa20032336fe78da341afc91c8a2341fc75f"
>  SRC_URI[num-integer-0.1.45.sha256sum] = "225d3389fb3509a24c93f5c29eb6bde2586b98d9f016636dff58d7c6f7569cd9"
> -SRC_URI[num-traits-0.2.15.sha256sum] = "578ede34cf02f8924ab9447f50c28075b4d3e5b269972345e7e0372b38c6cdcd"
> +SRC_URI[num-traits-0.2.16.sha256sum] = "f30b0abd723be7e2ffca1272140fac1a2f084c77ec3e123c192b66af1ee9e6c2"
>  SRC_URI[oid-registry-0.6.1.sha256sum] = "9bedf36ffb6ba96c2eb7144ef6270557b52e54b20c0a8e1eb2ff99a6c6959bff"
> -SRC_URI[once_cell-1.17.1.sha256sum] = "b7e5500299e16ebb147ae15a00a942af264cf3688f47923b8fc2cd5858f23ad3"
> -SRC_URI[proc-macro2-1.0.52.sha256sum] = "1d0e1ae9e836cc3beddd63db0df682593d7e2d3d891ae8c9083d2113e1744224"
> -SRC_URI[quote-1.0.26.sha256sum] = "4424af4bf778aae2051a77b60283332f386554255d722233d09fbfc7e30da2fc"
> +SRC_URI[once_cell-1.18.0.sha256sum] = "dd8b5dd2ae5ed71462c540258bedcb51965123ad7e7ccf4b9a8cafaa4a63576d"
> +SRC_URI[proc-macro2-1.0.66.sha256sum] = "18fb31db3f9bddb2ea821cde30a9f70117e3f119938b5ee630b7403aa6e2ead9"
> +SRC_URI[quote-1.0.32.sha256sum] = "50f3b39ccfb720540debaa0164757101c08ecb8d326b15358ce76a62c7e85965"
>  SRC_URI[ring-0.16.20.sha256sum] = "3053cf52e236a3ed746dfc745aa9cacf1b791d846bdaf412f60a8d7d6e17c8fc"
>  SRC_URI[rusticata-macros-4.1.0.sha256sum] = "faf0c4a6ece9950b9abdb62b1cfcf2a68b3b67a10ba445b3bb85be2a293d0632"
> -SRC_URI[serde-1.0.156.sha256sum] = "314b5b092c0ade17c00142951e50ced110ec27cea304b1037c6969246c2469a4"
> +SRC_URI[serde-1.0.180.sha256sum] = "0ea67f183f058fe88a4e3ec6e2788e003840893b91bac4559cabedd00863b3ed"
>  SRC_URI[spin-0.5.2.sha256sum] = "6e63cff320ae2c57904679ba7cb63280a3dc4613885beafb148ee7bf9aa9042d"
>  SRC_URI[syn-1.0.109.sha256sum] = "72b64191b275b66ffe2469e8af2c1cfe3bafa67b529ead792a6d0160888b4237"
> +SRC_URI[syn-2.0.28.sha256sum] = "04361975b3f5e348b2189d8dc55bc942f278b2d482a6a0365de5bdd62d351567"
>  SRC_URI[synstructure-0.12.6.sha256sum] = "f36bdaa60a83aca3921b5259d5400cbf5e90fc51931376a9bd4a0eb79aa7210f"
> -SRC_URI[thiserror-1.0.39.sha256sum] = "a5ab016db510546d856297882807df8da66a16fb8c4101cb8b30054b0d5b2d9c"
> -SRC_URI[thiserror-impl-1.0.39.sha256sum] = "5420d42e90af0c38c3290abcca25b9b3bdf379fc9f55c528f53a269d9c9a267e"
> -SRC_URI[time-0.3.20.sha256sum] = "cd0cbfecb4d19b5ea75bb31ad904eb5b9fa13f21079c3b92017ebdf4999a5890"
> -SRC_URI[time-core-0.1.0.sha256sum] = "2e153e1f1acaef8acc537e68b44906d2db6436e2b35ac2c6b42640fff91f00fd"
> -SRC_URI[time-macros-0.2.8.sha256sum] = "fd80a657e71da814b8e5d60d3374fc6d35045062245d80224748ae522dd76f36"
> -SRC_URI[unicode-ident-1.0.8.sha256sum] = "e5464a87b239f13a63a501f2701565754bae92d243d4bb7eb12f6d57d2269bf4"
> +SRC_URI[thiserror-1.0.44.sha256sum] = "611040a08a0439f8248d1990b111c95baa9c704c805fa1f62104b39655fd7f90"
> +SRC_URI[thiserror-impl-1.0.44.sha256sum] = "090198534930841fab3a5d1bb637cde49e339654e606195f8d9c76eeb081dc96"
> +SRC_URI[time-0.3.25.sha256sum] = "b0fdd63d58b18d663fbdf70e049f00a22c8e42be082203be7f26589213cd75ea"
> +SRC_URI[time-core-0.1.1.sha256sum] = "7300fbefb4dadc1af235a9cef3737cea692a9d97e1b9cbcd4ebdae6f8868e6fb"
> +SRC_URI[time-macros-0.2.11.sha256sum] = "eb71511c991639bb078fd5bf97757e03914361c48100d52878b8e52b46fb92cd"
> +SRC_URI[unicode-ident-1.0.11.sha256sum] = "301abaae475aa91687eb82514b328ab47a211a533026cb25fc3e519b86adfc3c"
>  SRC_URI[unicode-xid-0.2.4.sha256sum] = "f962df74c8c05a667b5ee8bcf162993134c104e96440b663c8daa176dc772d8c"
>  SRC_URI[untrusted-0.7.1.sha256sum] = "a156c684c91ea7d62626509bce3cb4e1d9ed5c4d978f7b4352658f96a4c26b4a"
> -SRC_URI[wasm-bindgen-0.2.84.sha256sum] = "31f8dcbc21f30d9b8f2ea926ecb58f6b91192c17e9d33594b3df58b2007ca53b"
> -SRC_URI[wasm-bindgen-backend-0.2.84.sha256sum] = "95ce90fd5bcc06af55a641a86428ee4229e44e07033963a2290a8e241607ccb9"
> -SRC_URI[wasm-bindgen-macro-0.2.84.sha256sum] = "4c21f77c0bedc37fd5dc21f897894a5ca01e7bb159884559461862ae90c0b4c5"
> -SRC_URI[wasm-bindgen-macro-support-0.2.84.sha256sum] = "2aff81306fcac3c7515ad4e177f521b5c9a15f2b08f4e32d823066102f35a5f6"
> -SRC_URI[wasm-bindgen-shared-0.2.84.sha256sum] = "0046fef7e28c3804e5e38bfa31ea2a0f73905319b677e57ebe37e49358989b5d"
> -SRC_URI[web-sys-0.3.61.sha256sum] = "e33b99f4b23ba3eec1a53ac264e35a755f00e966e0065077d6027c0f575b0b97"
> +SRC_URI[wasm-bindgen-0.2.87.sha256sum] = "7706a72ab36d8cb1f80ffbf0e071533974a60d0a308d01a5d0375bf60499a342"
> +SRC_URI[wasm-bindgen-backend-0.2.87.sha256sum] = "5ef2b6d3c510e9625e5fe6f509ab07d66a760f0885d858736483c32ed7809abd"
> +SRC_URI[wasm-bindgen-macro-0.2.87.sha256sum] = "dee495e55982a3bd48105a7b947fd2a9b4a8ae3010041b9e0faab3f9cd028f1d"
> +SRC_URI[wasm-bindgen-macro-support-0.2.87.sha256sum] = "54681b18a46765f095758388f2d0cf16eb8d4169b639ab575a8f5693af210c7b"
> +SRC_URI[wasm-bindgen-shared-0.2.87.sha256sum] = "ca6ad05a4870b2bf5fe995117d3728437bd27d7cd5f06f13c17443ef369775a1"
> +SRC_URI[web-sys-0.3.64.sha256sum] = "9b85cbef8c220a6abc02aefd892dfc0fc23afb1c6a426316ec33253a3877249b"
>  SRC_URI[winapi-0.3.9.sha256sum] = "5c839a674fcd7a98952e593242ea400abe93992746761e38641405d28b00f419"
>  SRC_URI[winapi-i686-pc-windows-gnu-0.4.0.sha256sum] = "ac3b87c63620426dd9b991e5ce0329eff545bccbbb34f3be09ff6fb6ab51b7b6"
>  SRC_URI[winapi-x86_64-pc-windows-gnu-0.4.0.sha256sum] = "712e227841d057c1ee1cd2fb22fa7e5a5461ae8e48fa2ca79ec42cfc1931183f"
> +# from rust/vendor/regex/Cargo.lock
> +
> +SRC_URI[aho-corasick-0.7.18.sha256sum] = "1e37cfd5e7657ada45f742d6e99ca5788580b5c529dc78faf11ece6dc702656f"
> +SRC_URI[cfg-if-1.0.0.sha256sum] = "baf1de4339761588bc0619e3cbc0120ee582ebb74b53b4efbf79117bd2da40fd"
> +SRC_URI[getrandom-0.2.6.sha256sum] = "9be70c98951c83b8d2f8f60d7065fa6d5146873094452a1008da8c2f1e4205ad"
> +SRC_URI[lazy_static-1.4.0.sha256sum] = "e2abad23fbc42b3700f2f279844dc832adb2b2eb069b2df918f455c4e18cc646"
> +SRC_URI[libc-0.2.125.sha256sum] = "5916d2ae698f6de9bfb891ad7a8d65c09d232dc58cc4ac433c7da3b2fd84bc2b"
> +SRC_URI[memchr-2.5.0.sha256sum] = "2dffe52ecf27772e601905b7522cb4ef790d2cc203488bbd0e2fe85fcb74566d"
> +SRC_URI[quickcheck-1.0.3.sha256sum] = "588f6378e4dd99458b60ec275b4477add41ce4fa9f64dcba6f15adccb19b50d6"
> +SRC_URI[rand-0.8.5.sha256sum] = "34af8d1a0e25924bc5b7c43c079c942339d8f0a8b57c39049bef581b46327404"
> +SRC_URI[rand_core-0.6.3.sha256sum] = "d34f1408f55294453790c48b2f1ebbb1c5b4b7563eb1f418bcfcfdbb06ebb4e7"
> +SRC_URI[regex-syntax-0.6.26.sha256sum] = "49b3de9ec5dc0a3417da371aab17d729997c15010e7fd24ff707773a33bddb64"
> +SRC_URI[wasi-0.10.2+wasi-snapshot-preview1.sha256sum] = "fd6fbd9a79829dd1ad0cc20627bf1ed606756a7f77edff7b66b7064f9cb327c6"
> +# from rust/vendor/bendy/Cargo.lock
> +
> +SRC_URI[addr2line-0.14.0.sha256sum] = "7c0929d69e78dd9bf5408269919fcbcaeb2e35e5d43e5815517cdc6a8e11a423"
> +SRC_URI[adler-0.2.3.sha256sum] = "ee2a4ec343196209d6594e19543ae87a39f96d5534d7174822a3ad825dd6ed7e"
> +SRC_URI[aho-corasick-0.7.15.sha256sum] = "7404febffaa47dac81aa44dba71523c9d069b1bdc50a77db41195149e17f68e5"
> +SRC_URI[autocfg-1.0.1.sha256sum] = "cdb031dd78e28731d87d56cc8ffef4a8f36ca26c38fe2de700543e627f8a464a"
> +SRC_URI[backtrace-0.3.54.sha256sum] = "2baad346b2d4e94a24347adeee9c7a93f412ee94b9cc26e5b59dea23848e9f28"
> +SRC_URI[cfg-if-1.0.0.sha256sum] = "baf1de4339761588bc0619e3cbc0120ee582ebb74b53b4efbf79117bd2da40fd"
> +SRC_URI[failure-0.1.8.sha256sum] = "d32e9bd16cc02eae7db7ef620b392808b89f6a5e16bb3497d159c6b92a0f4f86"
> +SRC_URI[failure_derive-0.1.8.sha256sum] = "aa4da3c766cd7a0db8242e326e9e4e081edd567072893ed320008189715366a4"
> +SRC_URI[gimli-0.23.0.sha256sum] = "f6503fe142514ca4799d4c26297c4248239fe8838d827db6bd6065c6ed29a6ce"
> +SRC_URI[lazy_static-1.4.0.sha256sum] = "e2abad23fbc42b3700f2f279844dc832adb2b2eb069b2df918f455c4e18cc646"
> +SRC_URI[libc-0.2.80.sha256sum] = "4d58d1b70b004888f764dfbf6a26a3b0342a1632d33968e4a179d8011c760614"
> +SRC_URI[memchr-2.3.4.sha256sum] = "0ee1c47aaa256ecabcaea351eae4a9b01ef39ed810004e298d2511ed284b1525"
> +SRC_URI[miniz_oxide-0.4.3.sha256sum] = "0f2d26ec3309788e423cfbf68ad1800f061638098d76a83681af979dc4eda19d"
> +SRC_URI[object-0.22.0.sha256sum] = "8d3b63360ec3cb337817c2dbd47ab4a0f170d285d8e5a2064600f3def1402397"
> +SRC_URI[proc-macro2-1.0.24.sha256sum] = "1e0704ee1a7e00d7bb417d0770ea303c1bccbabf0ef1667dae92b5967f5f8a71"
> +SRC_URI[quote-1.0.7.sha256sum] = "aa563d17ecb180e500da1cfd2b028310ac758de548efdd203e18f283af693f37"
> +SRC_URI[regex-1.4.2.sha256sum] = "38cf2c13ed4745de91a5eb834e11c00bcc3709e773173b2ce4c56c9fbde04b9c"
> +SRC_URI[regex-syntax-0.6.21.sha256sum] = "3b181ba2dcf07aaccad5448e8ead58db5b742cf85dfe035e2227f137a539a189"
> +SRC_URI[rustc-demangle-0.1.18.sha256sum] = "6e3bad0ee36814ca07d7968269dd4b7ec89ec2da10c4bb613928d3077083c232"
> +SRC_URI[serde-1.0.117.sha256sum] = "b88fa983de7720629c9387e9f517353ed404164b1e482c970a90c1a4aaf7dc1a"
> +SRC_URI[serde_bytes-0.11.5.sha256sum] = "16ae07dd2f88a366f15bd0632ba725227018c69a1c8550a927324f8eb8368bb9"
> +SRC_URI[serde_derive-1.0.117.sha256sum] = "cbd1ae72adb44aab48f325a02444a5fc079349a8d804c1fc922aed3f7454c74e"
> +SRC_URI[syn-1.0.48.sha256sum] = "cc371affeffc477f42a221a1e4297aedcea33d47d19b61455588bd9d8f6b19ac"
> +SRC_URI[synstructure-0.12.4.sha256sum] = "b834f2d66f734cb897113e34aaff2f1ab4719ca946f9a7358dba8f8064148701"
> +SRC_URI[thread_local-1.0.1.sha256sum] = "d40c6d1b69745a6ec6fb1ca717914848da4b44ae29d9b3080cbee91d72a69b14"
> +SRC_URI[unicode-xid-0.2.1.sha256sum] = "f7fe0bb3479651439c9112f72b6c505038574c9fbb575ed1bf3b797fa39dd564"
> +# from rust/vendor/flate2/Cargo.lock
> +
> +SRC_URI[adler-1.0.2.sha256sum] = "f26201604c87b1e01bd3d98f8d5d9a8fcbb815e8cedb41ffccbeb4bf593a35fe"
> +SRC_URI[cc-1.0.79.sha256sum] = "50d30906286121d95be3d479533b458f87493b30a4b5f79a607db8f5d11aa91f"
> +SRC_URI[cfg-if-1.0.0.sha256sum] = "baf1de4339761588bc0619e3cbc0120ee582ebb74b53b4efbf79117bd2da40fd"
> +SRC_URI[cloudflare-zlib-sys-0.3.0.sha256sum] = "2040b6d1edfee6d75f172d81e2d2a7807534f3f294ce18184c70e7bb0105cd6f"
> +SRC_URI[cmake-0.1.50.sha256sum] = "a31c789563b815f77f4250caee12365734369f942439b7defd71e18a48197130"
> +SRC_URI[crc32fast-1.3.2.sha256sum] = "b540bd8bc810d3885c6ea91e2018302f68baba2129ab3e88f32389ee9370880d"
> +SRC_URI[getrandom-0.2.9.sha256sum] = "c85e1d9ab2eadba7e5040d4e09cbd6d072b76a557ad64e797c2cb9d4da21d7e4"
> +SRC_URI[libc-0.2.144.sha256sum] = "2b00cc1c228a6782d0f076e7b232802e0c5689d41bb5df366f2a6b6621cfdfe1"
> +SRC_URI[libz-ng-sys-1.1.10.sha256sum] = "425fb6808068335c8c7c69d1cff0a7d1ed8f681e9ac040272f160a89e6f43b8b"
> +SRC_URI[libz-sys-1.1.10.sha256sum] = "24e6ab01971eb092ffe6a7d42f49f9ff42662f17604681e2843ad65077ba47dc"
> +SRC_URI[miniz_oxide-0.7.1.sha256sum] = "e7810e0be55b428ada41041c41f32c9f1a42817901b4ccf45fa3d4b6561e74c7"
> +SRC_URI[pkg-config-0.3.27.sha256sum] = "26072860ba924cbfa98ea39c8c19b4dd6a4a25423dbdf219c1eca91aa0cf6964"
> +SRC_URI[ppv-lite86-0.2.17.sha256sum] = "5b40af805b3121feab8a3c29f04d8ad262fa8e0561883e7653e024ae4479e6de"
> +SRC_URI[quickcheck-1.0.3.sha256sum] = "588f6378e4dd99458b60ec275b4477add41ce4fa9f64dcba6f15adccb19b50d6"
> +SRC_URI[rand-0.8.5.sha256sum] = "34af8d1a0e25924bc5b7c43c079c942339d8f0a8b57c39049bef581b46327404"
> +SRC_URI[rand_chacha-0.3.1.sha256sum] = "e6c10a63a0fa32252be49d21e7709d4d4baf8d231c2dbce1eaa8141b9b127d88"
> +SRC_URI[rand_core-0.6.4.sha256sum] = "ec0be4795e2f6a28069bec0b5ff3e2ac9bafc99e6a9a7dc3547996c5c816922c"
> +SRC_URI[vcpkg-0.2.15.sha256sum] = "accd4ea62f7bb7a82fe23066fb0957d48ef677f6eeb8215f372f52e48bb32426"
> +SRC_URI[wasi-0.11.0+wasi-snapshot-preview1.sha256sum] = "9c8d87e72b64a3b4db28d11ce29237c246188f4f51057d65a7eab63b7987e423"
> diff --git a/recipes-ids/suricata/suricata_7.0.0.bb b/recipes-ids/suricata/suricata_7.0.12.bb
> similarity index 95%
> rename from recipes-ids/suricata/suricata_7.0.0.bb
> rename to recipes-ids/suricata/suricata_7.0.12.bb
> index c36fbf1..e958fad 100644
> --- a/recipes-ids/suricata/suricata_7.0.0.bb
> +++ b/recipes-ids/suricata/suricata_7.0.12.bb
> @@ -5,7 +5,7 @@ require suricata.inc
>  LIC_FILES_CHKSUM = "file://LICENSE;beginline=1;endline=2;md5=c70d8d3310941dcdfcd1e02800a1f548"
>
>  SRC_URI = "http://www.openinfosecfoundation.org/download/suricata-${PV}.tar.gz"
> -SRC_URI[sha256sum] = "7bcd1313118366451465dc3f8385a3f6aadd084ffe44dd257dda8105863bb769"
> +SRC_URI[sha256sum] = "da5a591c749fed2bd986fc3b3cac25d9cfd3b453f57becf14610746999d3c5dd"
>
>  DEPENDS = "lz4 libhtp"
>
> @@ -15,12 +15,7 @@ SRC_URI += " \
>      file://suricata.yaml \
>      file://suricata.service \
>      file://run-ptest \
> -    file://fixup.patch \
> -    file://CVE-2024-37151.patch \
> -    file://CVE-2024-38534.patch \
> -    file://CVE-2024-38535_pre.patch \
> -    file://CVE-2024-38535.patch \
> -    file://CVE-2024-38536.patch \
> +    file://0001-Skip-pkg-Makefile-from-using-its-own-rust-steps.patch \
>      "
>
>  inherit autotools pkgconfig python3native systemd ptest cargo cargo-update-recipe-crates
>

