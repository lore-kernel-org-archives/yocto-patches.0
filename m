Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9450FC982D8
	for <webhook@archiver.kernel.org>; Sat, 19 Sep 2026 16:13:59 +0000 (UTC)
Received: from mail-qk2-f12.google.com (mail-qk2-f12.google.com [74.125.230.204])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.15016.1789834437052830463
 for <yocto-patches@lists.yoctoproject.org>;
 Sat, 19 Sep 2026 09:13:57 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=HoGDgkSF;
 spf=pass (domain: konsulko.com, ip: 74.125.230.204, mailfrom: scott.murray@konsulko.com)
Received: by mail-qk2-f12.google.com with SMTP id af79cd13be357-939109fafddso117521285a.0
        for <yocto-patches@lists.yoctoproject.org>; Sat, 19 Sep 2026 09:13:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1789834436; x=1790439236; darn=lists.yoctoproject.org;
        h=content-type:mime-version:references:message-id:in-reply-to:subject
         :to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ehGbmOOU6uYgJysFWOwpgZPLYqUxGQfCeUZngFu7z4E=;
        b=HoGDgkSFlBEopGtSCisGaAayXZzYsxPrJVjVxXztwhuwcI2oVDiKpE5Mx0qafBf9kt
         milhj9+SNqpLaL9DbaoVFe7PA3e6Eo932mvulJ1OtP0/c2rZpddSMQBBdB13V8t4AFG6
         uaGUDCmhpUH1McM+/OcSoW/5+TcAMwwcpCL2w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789834436; x=1790439236;
        h=content-type:mime-version:references:message-id:in-reply-to:subject
         :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ehGbmOOU6uYgJysFWOwpgZPLYqUxGQfCeUZngFu7z4E=;
        b=rn0VWJTzWR8zoWI6eWCBHBSI8AJtTTAse/3OzyOC7fE8mx6bWVnaEbsYY33bNeSDmq
         hcdt0z1x4PcjBTsk8Fnk5nrspLy7pILCbYdqj8ZJTPgG4XJp5XEpUM+EN0p/GRipu8Br
         t6DeVRr2ywkC1gP/9RTpCkdacqFPqV31rrpZu4spI8buQE6K3p3xie6DYH0BDO28bhUx
         jb/F2D0hydUa2FUBwE8UpeATxA9TbMnTbvbTBpdqO72zyZ6SqFIlv4wgYqJQz7Wzh4V+
         bLDXurp3Wgul5Dgkvi9KE2kftvqPPpMAT6MqycOuVKlJ9IhTZ8BO+L/2RzB/aJXBTfXh
         ZAfw==
X-Gm-Message-State: AFuF++nt8YerOZ6FEmZPliJAWlyPKcj9eKIO/GBvJ90M/6r8CpZYkX2j
	wtuvWi9nTG8kKeDPfuUUntzXbs/5Fx+UwrIjSiExtLxNawAv+6dAjDuaOfDHuhRgI60zjLi+Wq3
	MOMuH9OI=
X-Gm-Gg: AYBFou1mWuNwS6o1ANdOKDvXfzze6au3djyO17pNYOUaOGPPOgVHPf8FKy5Zu3/FJ/1
	E8kALZSW0hXWMgSJNdhAdHyscoVFCFnCmQz3zDr0MhdvaRAhmRrgOQXCs75P/HbFS4UFOBv/WI2
	eI71Y79RoJAhwg0yIbKLrLTv8aTzK+DmWF6vdgWsRaMV5wrmqomaGwaB2OeNNacogCFjb7X0k5M
	SLzK5Fk9HZt5P+w86R++9yB+AORUZbgzpFHJB+vhpvENmTcxLaWa06unkzRvtEnWy+5q7T41+rJ
	nFnz/EsZCqE9qMg183SK074Lx6i0KPP5agvm8LJbwnd60/vMfXPw8h+Mekm4vAz+nT78r8WcR47
	9BCFy+YLrq4KJysXhImi24eh6yqAwbJaLhSTFCpl+rBNiWH6bUSzR1i5CIakM9Cs7B6N+4tgD+i
	40hUYBI5rE1HqRzStWRzlikSlKsoj5qRfIJThL9Cg8ZuwAVzPhZaoi9NBHPfEfsmYIz8qUBlJ/C
	bnHXJ9zQd9yJeTACrT1K/rJUGXo/yBi3wM2rGdm0vGIPyXNwIdWHlf0HM+7S3J33cP8NMapACUZ
	YXng8bii0Zp0VMqsHw==
X-Received: by 2002:a05:620a:4416:b0:939:a9d4:50b7 with SMTP id af79cd13be357-93bf557a29amr234728985a.26.1789834435574;
        Sat, 19 Sep 2026 09:13:55 -0700 (PDT)
Received: from godzilla (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91260aa15cdsm23728346d6.41.2026.09.19.09.13.54
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Sep 2026 09:13:54 -0700 (PDT)
Date: Sat, 19 Sep 2026 12:13:54 -0400 (EDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: Re: [yocto-patches] [meta-security][wrynose][PATCH 00/24] Assorted
 updates 09/16
In-Reply-To: <18D5EDBF13225329.668921@lists.yoctoproject.org>
Message-ID: <fac40dbc-ed56-a7c8-9bc3-623ee9ed5f42@konsulko.com>
References: <18D5EDBF13225329.668921@lists.yoctoproject.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="-1463811583-1650600615-1789834434=:3910"
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sat, 19 Sep 2026 16:13:59 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4908

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463811583-1650600615-1789834434=:3910
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Wed, 16 Sep 2026, Scott Murray via lists.yoctoproject.org wrote:

> This patch series rolls up the contributed patches from the past few
> months along with a bunch of package updates and backports from master
> from myself.  These changes are queued on the wrynose-next branch if
> you would like to check them out to test yourself.  I intend to merge
> these to wrynose branch Friday evening (EDT, September 18) unless
> there are objections.

These changes have now been merged to wrynose branch.

Scott


> Changes:
>
> Bin Cao (1):
>   samhain: fix server startup failure on systemd-based systems
>
> Esa Jaaskela (1):
>   aide: Fix unstable install task hash
>
> Gaël PORTAY (3):
>   dm-verity: remove unused variable
>   wic: document the meta-intel dependency in the dm-verity hash example
>   docs: update path of wic files
>
> Khem Raj (2):
>   tpm2-tools: Upgrade 5.7 -> 5.8
>   tpm2-pkcs11: Upgrade 1.9.2 -> 1.10.1
>
> Krupal Ka Patel (1):
>   tpm2-tools: fix PACKAGECONFIG typo
>
> Peter Marko (2):
>   tpm2-tools: set status for CVE-2017-7524 and CVE-2024-29039
>   tpm2-tss: set status for CVE-2024-29040
>
> Sandeep J (1):
>   README: fix broken URLs in meta-integrity and ccs-tools
>
> Scott Murray (11):
>   meta-tpm: Fix SUMMARY/HOMEPAGE in affected recipes
>   openscap: upgrade 1.4.3 -> 1.4.4
>   scap-security-guide: upgrade 0.1.80 -> 0.1.81
>   sssd: upgrade 2.10.2 -> 2.13.1
>   krill: upgrade 0.12.3 -> 0.16.0
>   ossec-hids: upgrade 3.7.0 -> 4.3.0
>   clamav: upgrade 1.4.4 -> 1.4.6
>   aide: upgrade 0.19.3 -> 0.19.4
>   crowdsec: upgrade 1.7.7 -> 1.8.1
>   suricata: upgrade 8.0.4 -> 8.0.6
>   lynis: upgrade 3.1.6 -> 3.1.7
>
> Shreejit C (1):
>   meta-tpm: Add missing recipe metadata (HOMEPAGE/SUMMARY)
>
> Wang Mingyu (1):
>   ccs-tools: upgrade 1.8.9 -> 1.8.14
>
>  classes/aide-db-init.bbclass                  |   11 +-
>  classes/dm-verity-img.bbclass                 |    1 -
>  docs/dm-verity-systemd-x86-64.txt             |    6 +-
>  docs/dm-verity.txt                            |    2 +-
>  .../sssd/files/drop_ntpdate_chk.patch         |   17 +-
>  .../sssd/files/fix-ldblibdir.patch            |    9 +-
>  .../recipes-security/sssd/files/fix_gid.patch |   18 +-
>  .../sssd/files/musl_fixup.patch               |   38 +-
>  .../recipes-security/sssd/files/no_gen.patch  |   18 +-
>  .../sssd/{sssd_2.10.2.bb => sssd_2.13.1.bb}   |    4 +-
>  .../wic/systemd-bootdisk-dmverity-hash.wks.in |    1 +
>  meta-integrity/README.md                      |    4 +-
>  .../recipes-core/images/security-tpm-image.bb |    2 +-
>  .../images/security-tpm2-image.bb             |    2 +-
>  .../packagegroup/packagegroup-security-tpm.bb |    2 +-
>  .../packagegroup-security-tpm2.bb             |    1 +
>  meta-tpm/recipes-tpm/libtpm/libtpms_0.10.0.bb |    1 +
>  meta-tpm/recipes-tpm/swtpm/swtpm_0.10.0.bb    |    1 +
>  .../openssl-tpm-engine_0.5.0.bb               |    2 +-
>  .../tpm-tools/tpm-tools_1.3.9.2.bb            |    1 +
>  .../tpm2-abrmd/tpm2-abrmd_3.0.0.bb            |    1 +
>  .../tpm2-openssl/tpm2-openssl_1.3.0.bb        |    1 +
>  ...eturn-NULL-for-twist-on-auth-failure.patch |   28 -
>  ...-pkcs11_1.9.2.bb => tpm2-pkcs11_1.10.1.bb} |    4 +-
>  .../tpm2-pytss/python3-tpm2-pytss_2.3.0.bb    |    1 +
>  .../{tpm2-tools_5.7.bb => tpm2-tools_5.8.bb}  |   10 +-
>  .../tpm2-tss-engine/tpm2-tss-engine_1.2.0.bb  |    1 +
>  .../recipes-tpm2/tpm2-tss/tpm2-tss_4.1.3.bb   |    3 +
>  .../lynis/{lynis_3.1.6.bb => lynis_3.1.7.bb}  |    2 +-
>  .../{openscap_1.4.3.bb => openscap_1.4.4.bb}  |    4 +-
>  ....1.80.bb => scap-security-guide_0.1.81.bb} |    0
>  .../aide/{aide_0.19.3.bb => aide_0.19.4.bb}   |   15 +-
>  recipes-ids/crowdsec/crowdsec-go-mods.inc     |  408 ++-
>  recipes-ids/crowdsec/crowdsec-licenses.inc    |  321 +-
>  .../{crowdsec_1.7.7.bb => crowdsec_1.8.1.bb}  |    2 +-
>  ...Makefile-drop-running-scrips-install.patch |    7 +-
>  .../0002-Makefile-don-t-set-uid-gid.patch     |    7 +-
>  ...ssec-hids_3.7.0.bb => ossec-hids_4.3.0.bb} |    4 +-
>  ...-set-SetLockfilePath-to-run-yule.pid.patch |   41 +
>  recipes-ids/samhain/files/samhain-client.init |    3 +-
>  recipes-ids/samhain/files/samhain-server.init |    3 +-
>  recipes-ids/samhain/samhain.inc               |    1 +
>  recipes-ids/suricata/suricata-crates.inc      | 2995 +++++++++--------
>  .../{suricata_8.0.4.bb => suricata_8.0.6.bb}  |    2 +-
>  recipes-mac/ccs-tools/README                  |    2 +-
>  ...ccs-tools_1.8.9.bb => ccs-tools_1.8.14.bb} |    6 +-
>  .../{clamav_1.4.4.bb => clamav_1.4.6.bb}      |    2 +-
>  .../files/0001-Disable-abort-on-panic.patch   |   24 +
>  .../krill/files/panic_workaround.patch        |   16 -
>  recipes-security/krill/krill-crates.inc       | 1332 +++++---
>  .../{krill_0.12.3.bb => krill_0.16.0.bb}      |    8 +-
>  51 files changed, 2894 insertions(+), 2501 deletions(-)
>  rename dynamic-layers/networking-layer/recipes-security/sssd/{sssd_2.10.2.bb => sssd_2.13.1.bb} (98%)
>  delete mode 100644 meta-tpm/recipes-tpm2/tpm2-pkcs11/files/0001-src-lib-tpm-return-NULL-for-twist-on-auth-failure.patch
>  rename meta-tpm/recipes-tpm2/tpm2-pkcs11/{tpm2-pkcs11_1.9.2.bb => tpm2-pkcs11_1.10.1.bb} (90%)
>  rename meta-tpm/recipes-tpm2/tpm2-tools/{tpm2-tools_5.7.bb => tpm2-tools_5.8.bb} (56%)
>  rename recipes-compliance/lynis/{lynis_3.1.6.bb => lynis_3.1.7.bb} (96%)
>  rename recipes-compliance/openscap/{openscap_1.4.3.bb => openscap_1.4.4.bb} (98%)
>  rename recipes-compliance/scap-security-guide/{scap-security-guide_0.1.80.bb => scap-security-guide_0.1.81.bb} (100%)
>  rename recipes-ids/aide/{aide_0.19.3.bb => aide_0.19.4.bb} (81%)
>  rename recipes-ids/crowdsec/{crowdsec_1.7.7.bb => crowdsec_1.8.1.bb} (96%)
>  rename recipes-ids/ossec/{ossec-hids_3.7.0.bb => ossec-hids_4.3.0.bb} (99%)
>  create mode 100644 recipes-ids/samhain/files/0013-yulerc-set-SetLockfilePath-to-run-yule.pid.patch
>  rename recipes-ids/suricata/{suricata_8.0.4.bb => suricata_8.0.6.bb} (98%)
>  rename recipes-mac/ccs-tools/{ccs-tools_1.8.9.bb => ccs-tools_1.8.14.bb} (84%)
>  rename recipes-scanners/clamav/{clamav_1.4.4.bb => clamav_1.4.6.bb} (99%)
>  create mode 100644 recipes-security/krill/files/0001-Disable-abort-on-panic.patch
>  delete mode 100644 recipes-security/krill/files/panic_workaround.patch
>  rename recipes-security/krill/{krill_0.12.3.bb => krill_0.16.0.bb} (89%)
>
>
---1463811583-1650600615-1789834434=:3910--

