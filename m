Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08132C982C1
	for <webhook@archiver.kernel.org>; Wed, 16 Sep 2026 22:30:42 +0000 (UTC)
Received: from mail-qk2-f12.google.com (mail-qk2-f12.google.com [74.125.230.204])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.27117.1789597831599411812
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 16 Sep 2026 15:30:31 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=Pc67jee3;
 spf=pass (domain: konsulko.com, ip: 74.125.230.204, mailfrom: scott.murray@konsulko.com)
Received: by mail-qk2-f12.google.com with SMTP id af79cd13be357-93a222edc62so20321785a.0
        for <yocto-patches@lists.yoctoproject.org>; Wed, 16 Sep 2026 15:30:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1789597830; x=1790202630; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ql45kBrQem0U8e2A2O41naxxDurvVygvob9i1P7mJkg=;
        b=Pc67jee3Qquhk8w3JExYQdvfr5++QUcb00bE0+vNhhUnvinyPYUJQieUAlTYoZ+lwZ
         MF6/cSbmBJyKEIXPoItVMdUj+Mm1GLlJryH80JWKhQ6tXJCsRRemS9y0ISP/Dpk7UrLA
         wMAJBejMrseM/ZW8NsjhdPxl1PlPHZpVuM2Os=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789597830; x=1790202630;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Ql45kBrQem0U8e2A2O41naxxDurvVygvob9i1P7mJkg=;
        b=dHv71EtGkF8zjr++oxbxwbOyjUIl6rkF24wL0t0b9BC7xdKRlpTuqPtfDlHUueYNMn
         /hccwqs612GO9V5CT8FPD0H6eovM2j6fMcF6EZDxINKAEiMdkZwN2uG6G+SNTaOvy7iY
         lBp4qR+qWeZXhHp/ylaPEr2SfffakwGC8g0jkRWesqeFC93c85ocyAy76vqT1zQfHnt5
         idl3+PnvTefhHHem1+pCdao0ADXiGMhBQpvWIi5Lmv1cnkQN4Z4mBSPPJQ48B3igbUN0
         YK3UwBo1XPweiZi4GjAHj0A0HidUVRVlfc+AnZGnFLtY/ymOrZgeswea1+eSByCj99/M
         nh6g==
X-Gm-Message-State: AFuF++kUVfk/HxSAav2kX9rm5TO4CcdYG0N69SjMT+YoPyyu1oO3gw6R
	CbVpWNHql0kteLH2O2/RaoI1/ZXPIt2q83eVf5zSthARpI1BYvkm7WPgHGd5R9y5lIjbUGnv7PU
	M//Ep
X-Gm-Gg: AYBFou21++gTLL2m68tHPu1CDU7Wp2vK/A9/ff7NUKBwWaaELIi/hTMU81Lc9TzhiKE
	WWnJP87aMjtQ+oKY5Q/BoK6FI2vpZGNxmnT5LnHp1/20Wu78KTskKCLOZYnSJbquxqdI6pEXeoE
	7wRBCm0o4+Uon3No3I0Mlqr4Lq4lck5I0xtQ1DDqYfZ4zmPDErfHh5xekEZgpgPJ0xSbgYxkAjs
	wKgUDu8a46BYLF/O6omexGvemRgp2nyWoYE+4FGvtg52eR3GP6BjOWKw/RmPANGUuxYp+WT9b2p
	y02LBvTQZFzreTe281u6tnVv3UeHxwHiAzU1PSn9RstthNa8hHV2aBY0eDYgvU9I0DSnAKfItnq
	zrTsuMSkePep+CKT/2ol2O6ipmfFX4RZovpGUk7DDzf+b6LEMft+9zpoJJsKqDVHMEt/wBj09yg
	b6FB08DjccbrQvAazc4/q1yH+q/1aFVjQadXf7ROVXxijL8hBm7ZFmJWJcWWd0I6j1TP5T4E42F
	QnsDxaxVINdiJgHscYwDfb9x9IXXGX936uu5zZZv9EvEHs/0PCJM8t9B3G81ofdkRlSIG/Qa776
	lDA2coqqoed1hp0+/nUbRSFCJyBhbUTHGA8=
X-Received: by 2002:a05:620a:8006:b0:939:7c8:78a9 with SMTP id af79cd13be357-93bb76a7ba5mr839584285a.3.1789597830148;
        Wed, 16 Sep 2026 15:30:30 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93b781d94c0sm310900685a.10.2026.09.16.15.30.29
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 15:30:29 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-security][wrynose][PATCH 00/24] Assorted updates 09/16
Date: Wed, 16 Sep 2026 18:29:54 -0400
Message-ID: <cover.1789597604.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 16 Sep 2026 22:30:42 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4876

This patch series rolls up the contributed patches from the past few
months along with a bunch of package updates and backports from master
from myself.  These changes are queued on the wrynose-next branch if
you would like to check them out to test yourself.  I intend to merge
these to wrynose branch Friday evening (EDT, September 18) unless
there are objections.

Scott


Changes:

Bin Cao (1):
  samhain: fix server startup failure on systemd-based systems

Esa Jaaskela (1):
  aide: Fix unstable install task hash

Gaël PORTAY (3):
  dm-verity: remove unused variable
  wic: document the meta-intel dependency in the dm-verity hash example
  docs: update path of wic files

Khem Raj (2):
  tpm2-tools: Upgrade 5.7 -> 5.8
  tpm2-pkcs11: Upgrade 1.9.2 -> 1.10.1

Krupal Ka Patel (1):
  tpm2-tools: fix PACKAGECONFIG typo

Peter Marko (2):
  tpm2-tools: set status for CVE-2017-7524 and CVE-2024-29039
  tpm2-tss: set status for CVE-2024-29040

Sandeep J (1):
  README: fix broken URLs in meta-integrity and ccs-tools

Scott Murray (11):
  meta-tpm: Fix SUMMARY/HOMEPAGE in affected recipes
  openscap: upgrade 1.4.3 -> 1.4.4
  scap-security-guide: upgrade 0.1.80 -> 0.1.81
  sssd: upgrade 2.10.2 -> 2.13.1
  krill: upgrade 0.12.3 -> 0.16.0
  ossec-hids: upgrade 3.7.0 -> 4.3.0
  clamav: upgrade 1.4.4 -> 1.4.6
  aide: upgrade 0.19.3 -> 0.19.4
  crowdsec: upgrade 1.7.7 -> 1.8.1
  suricata: upgrade 8.0.4 -> 8.0.6
  lynis: upgrade 3.1.6 -> 3.1.7

Shreejit C (1):
  meta-tpm: Add missing recipe metadata (HOMEPAGE/SUMMARY)

Wang Mingyu (1):
  ccs-tools: upgrade 1.8.9 -> 1.8.14

 classes/aide-db-init.bbclass                  |   11 +-
 classes/dm-verity-img.bbclass                 |    1 -
 docs/dm-verity-systemd-x86-64.txt             |    6 +-
 docs/dm-verity.txt                            |    2 +-
 .../sssd/files/drop_ntpdate_chk.patch         |   17 +-
 .../sssd/files/fix-ldblibdir.patch            |    9 +-
 .../recipes-security/sssd/files/fix_gid.patch |   18 +-
 .../sssd/files/musl_fixup.patch               |   38 +-
 .../recipes-security/sssd/files/no_gen.patch  |   18 +-
 .../sssd/{sssd_2.10.2.bb => sssd_2.13.1.bb}   |    4 +-
 .../wic/systemd-bootdisk-dmverity-hash.wks.in |    1 +
 meta-integrity/README.md                      |    4 +-
 .../recipes-core/images/security-tpm-image.bb |    2 +-
 .../images/security-tpm2-image.bb             |    2 +-
 .../packagegroup/packagegroup-security-tpm.bb |    2 +-
 .../packagegroup-security-tpm2.bb             |    1 +
 meta-tpm/recipes-tpm/libtpm/libtpms_0.10.0.bb |    1 +
 meta-tpm/recipes-tpm/swtpm/swtpm_0.10.0.bb    |    1 +
 .../openssl-tpm-engine_0.5.0.bb               |    2 +-
 .../tpm-tools/tpm-tools_1.3.9.2.bb            |    1 +
 .../tpm2-abrmd/tpm2-abrmd_3.0.0.bb            |    1 +
 .../tpm2-openssl/tpm2-openssl_1.3.0.bb        |    1 +
 ...eturn-NULL-for-twist-on-auth-failure.patch |   28 -
 ...-pkcs11_1.9.2.bb => tpm2-pkcs11_1.10.1.bb} |    4 +-
 .../tpm2-pytss/python3-tpm2-pytss_2.3.0.bb    |    1 +
 .../{tpm2-tools_5.7.bb => tpm2-tools_5.8.bb}  |   10 +-
 .../tpm2-tss-engine/tpm2-tss-engine_1.2.0.bb  |    1 +
 .../recipes-tpm2/tpm2-tss/tpm2-tss_4.1.3.bb   |    3 +
 .../lynis/{lynis_3.1.6.bb => lynis_3.1.7.bb}  |    2 +-
 .../{openscap_1.4.3.bb => openscap_1.4.4.bb}  |    4 +-
 ....1.80.bb => scap-security-guide_0.1.81.bb} |    0
 .../aide/{aide_0.19.3.bb => aide_0.19.4.bb}   |   15 +-
 recipes-ids/crowdsec/crowdsec-go-mods.inc     |  408 ++-
 recipes-ids/crowdsec/crowdsec-licenses.inc    |  321 +-
 .../{crowdsec_1.7.7.bb => crowdsec_1.8.1.bb}  |    2 +-
 ...Makefile-drop-running-scrips-install.patch |    7 +-
 .../0002-Makefile-don-t-set-uid-gid.patch     |    7 +-
 ...ssec-hids_3.7.0.bb => ossec-hids_4.3.0.bb} |    4 +-
 ...-set-SetLockfilePath-to-run-yule.pid.patch |   41 +
 recipes-ids/samhain/files/samhain-client.init |    3 +-
 recipes-ids/samhain/files/samhain-server.init |    3 +-
 recipes-ids/samhain/samhain.inc               |    1 +
 recipes-ids/suricata/suricata-crates.inc      | 2995 +++++++++--------
 .../{suricata_8.0.4.bb => suricata_8.0.6.bb}  |    2 +-
 recipes-mac/ccs-tools/README                  |    2 +-
 ...ccs-tools_1.8.9.bb => ccs-tools_1.8.14.bb} |    6 +-
 .../{clamav_1.4.4.bb => clamav_1.4.6.bb}      |    2 +-
 .../files/0001-Disable-abort-on-panic.patch   |   24 +
 .../krill/files/panic_workaround.patch        |   16 -
 recipes-security/krill/krill-crates.inc       | 1332 +++++---
 .../{krill_0.12.3.bb => krill_0.16.0.bb}      |    8 +-
 51 files changed, 2894 insertions(+), 2501 deletions(-)
 rename dynamic-layers/networking-layer/recipes-security/sssd/{sssd_2.10.2.bb => sssd_2.13.1.bb} (98%)
 delete mode 100644 meta-tpm/recipes-tpm2/tpm2-pkcs11/files/0001-src-lib-tpm-return-NULL-for-twist-on-auth-failure.patch
 rename meta-tpm/recipes-tpm2/tpm2-pkcs11/{tpm2-pkcs11_1.9.2.bb => tpm2-pkcs11_1.10.1.bb} (90%)
 rename meta-tpm/recipes-tpm2/tpm2-tools/{tpm2-tools_5.7.bb => tpm2-tools_5.8.bb} (56%)
 rename recipes-compliance/lynis/{lynis_3.1.6.bb => lynis_3.1.7.bb} (96%)
 rename recipes-compliance/openscap/{openscap_1.4.3.bb => openscap_1.4.4.bb} (98%)
 rename recipes-compliance/scap-security-guide/{scap-security-guide_0.1.80.bb => scap-security-guide_0.1.81.bb} (100%)
 rename recipes-ids/aide/{aide_0.19.3.bb => aide_0.19.4.bb} (81%)
 rename recipes-ids/crowdsec/{crowdsec_1.7.7.bb => crowdsec_1.8.1.bb} (96%)
 rename recipes-ids/ossec/{ossec-hids_3.7.0.bb => ossec-hids_4.3.0.bb} (99%)
 create mode 100644 recipes-ids/samhain/files/0013-yulerc-set-SetLockfilePath-to-run-yule.pid.patch
 rename recipes-ids/suricata/{suricata_8.0.4.bb => suricata_8.0.6.bb} (98%)
 rename recipes-mac/ccs-tools/{ccs-tools_1.8.9.bb => ccs-tools_1.8.14.bb} (84%)
 rename recipes-scanners/clamav/{clamav_1.4.4.bb => clamav_1.4.6.bb} (99%)
 create mode 100644 recipes-security/krill/files/0001-Disable-abort-on-panic.patch
 delete mode 100644 recipes-security/krill/files/panic_workaround.patch
 rename recipes-security/krill/{krill_0.12.3.bb => krill_0.16.0.bb} (89%)

-- 
2.55.0


