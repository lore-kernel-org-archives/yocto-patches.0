Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C1CBC982C1
	for <webhook@archiver.kernel.org>; Wed, 16 Sep 2026 21:58:40 +0000 (UTC)
Received: from mail-qk2-f12.google.com (mail-qk2-f12.google.com [74.125.230.204])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.26506.1789595917815571910
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 16 Sep 2026 14:58:38 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=YFdLPV96;
 spf=pass (domain: konsulko.com, ip: 74.125.230.204, mailfrom: scott.murray@konsulko.com)
Received: by mail-qk2-f12.google.com with SMTP id af79cd13be357-93a135ffb08so17751685a.2
        for <yocto-patches@lists.yoctoproject.org>; Wed, 16 Sep 2026 14:58:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1789595917; x=1790200717; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=+6ZfTojWkhCXLmPExEcPZQrhAFRi2I2cYAjtKDkoEPI=;
        b=YFdLPV963nLuZZ7jR5ryDOmq286vfOZ9CU/Y6HPCE2qskd4KlR2tXibE426efF841P
         /ycoE6+wGTw1nh+bJ9owawBKhpADfX3tIA4+LO2C7CIpb5d3m7FP3rRdR0eqrBQii2m0
         dP6BrDA2E8X6cxRxq2cybDE4aTkC6p8BQsYMs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789595917; x=1790200717;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=+6ZfTojWkhCXLmPExEcPZQrhAFRi2I2cYAjtKDkoEPI=;
        b=Tf6WBY2pkHm3rbxYsjtkSCZrYzcmtMVN/2JO2+NapE4FJJjIls1pyjOzTlic7L5a0E
         ktW0u5cc9rbXEjvu8ZRFvAob3ujaTZ4kG18p5DAX+yOEQlho29QdrKHEno7nUqt47rCT
         NUj5rI+B4x00kX8iN/m/77VHnyg3gLz0aTsE2pX85a0L2ZgdtdkKRQ3gQgWB6Wyfl4D8
         rbUU8IhHcnfIkXl/iC1EXoi6A0WWdePSvGy7+sib4wRu3IVo4qwPNQLm51zwDYUCRYHV
         P/lMgJWF+hIdNXt3fHN/9bqRcIraAEMhAFt1RBmdoiMGXMkwz9tyxunj1N4nJpN0DphZ
         PRRg==
X-Gm-Message-State: AFuF++l0HNlcmJ084+sw8oZDOxrMg7C+KrLvD9h6S8gHYyep4g6rp4jC
	pQWeP0kZF1R2pc5q6gM+jXYuIXEji8ZzBjxx7gHvssTCYE3JRmXyuq6b45bpbR9l6kIa2gnsW4f
	nlUkG
X-Gm-Gg: AYBFou0kt7ZoMxBfg4legYV9JtAL1wj1epqUmrGwonIe2yr+NW7+qQO4rl3wYQU8AdQ
	mckff4mwcttRyTEC6Tf4beeQu1GvCRab8p1Z5itT715jbf1i/E823ntNPpxD0nUi5lfIb79QBWT
	zFE4uEbnUshXecn+1ytRouEINKnYhnFYUpoKCO+URWuX33P9oPCCk9xFs6NXT6LjoZCDdV9+vAE
	nmFuVvIT2QYK7Uz0JK5Fh6tCtF+iNXIt45r7nbF43TgTsFP4UbN0TtI27iZCWrusqkRkmG7aIg6
	EHJQ7V6SXo3zTJSa+os1BJMvVFETUXxzEo0AGzyKktyMsw4HPJ29gpFeCopAGzQY7Isnf1xrY7j
	LtXrHUOebkFccx+YYYn5RS+iz1APm+brIEQ5Ezj1YyukbhkQ/UNo5Fbla3VUMykcIXZ5dAc6u1m
	1zAMqArH5zZoQDl7MPyJSGt7Ff9w7Uu+TMB3w6W77UwxtzLBUgoizIgSa8hlaeaTiRp1/I4eBgo
	G19dc7rEMJHCcmqXtFZw7C4Idni6aFapv1Ux1J9eS6jHk1tY9ll4w4LsUtsvOhWzgvIW8B+Mk/z
	R5Cu/DaoF0p2nRu8iZtfhWRTQ57njzQmDE8=
X-Received: by 2002:a05:620a:2551:b0:939:d5f4:ab5d with SMTP id af79cd13be357-93bb785be6emr757896185a.33.1789595916333;
        Wed, 16 Sep 2026 14:58:36 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93b781def43sm323293085a.16.2026.09.16.14.58.34
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 14:58:35 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-security][PATCH 00/19] Assorted updates 09/16
Date: Wed, 16 Sep 2026 17:58:00 -0400
Message-ID: <cover.1789595456.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 16 Sep 2026 21:58:40 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4856

This patch series rolls up the contributed patches from the past few
weeks along with a bunch more OpenSSL 4.0 fixes and package updates
from myself.  These changes are queued on the master-next branch if
you would like to check them out to test yourself.  I intend to merge
these to master branch Friday evening (EDT, September 18) unless
there are objections.

If you happen to use ossec-hids, or have experience with fixing up
OpenSSL 4.0 API breakage, I would appreciate some eyes on the patch
I've cooked up to get it building.  I do intend to submit it upstream,
but need to find some cycles to do some build testing with older
versions of OpenSSL.

Scott


Changes:

Khem Raj (5):
  tpm2-tools: Upgrade 5.7 -> 5.8
  trousers: Fix build with OpenSSL 4.x
  tpm2-openssl: Fix build with OpenSSL 4.x
  tpm2-pkcs11: Upgrade 1.9.2 -> 1.10.1
  meta-tpm: Remove tpm2-tss-engine

Scott Murray (13):
  ncrack: fix OpenSSL 4.0 breakage
  openscap: upgrade 1.4.3 -> 1.4.4
  scap-security-guide: upgrade 0.1.80 -> 0.1.81
  sssd: upgrade 2.10.2 -> 2.13.1
  krill: upgrade 0.12.3 -> 0.16.0
  ossec-hids: upgrade 3.7.0 -> 4.3.0
  clamav: upgrade 1.4.4 -> 1.4.6
  clamav: upgrade 1.4.6 -> 1.5.4
  meta-tpm: Remove openssl-tpm-engine
  aide: upgrade 0.19.3 -> 0.19.4
  crowdsec: upgrade 1.7.7 -> 1.8.1
  suricata: upgrade 8.0.4 -> 8.0.6
  lynis: upgrade 3.1.6 -> 3.1.7

Wang Mingyu (1):
  ccs-tools: upgrade 1.8.9 -> 1.8.14

 .../sssd/files/drop_ntpdate_chk.patch         |   17 +-
 .../sssd/files/fix-ldblibdir.patch            |    9 +-
 .../recipes-security/sssd/files/fix_gid.patch |   18 +-
 .../sssd/files/musl_fixup.patch               |   38 +-
 .../recipes-security/sssd/files/no_gen.patch  |   18 +-
 .../sssd/{sssd_2.10.2.bb => sssd_2.13.1.bb}   |    4 +-
 .../distro/include/maintainers-meta-tpm.inc   |    2 -
 .../packagegroup/packagegroup-security-tpm.bb |    1 -
 .../packagegroup-security-tpm2.bb             |    2 -
 ...pm-key-support-well-known-key-option.patch |  101 -
 .../0002-libtpm-support-env-TPM_SRK_PW.patch  |   82 -
 ...engine-parse-an-encrypted-tpm-SRK-pa.patch |  253 --
 ...engine-change-variable-c-type-from-c.patch |   33 -
 .../files/openssl11_build_fix.patch           |   34 -
 .../openssl-tpm-engine_0.5.0.bb               |   63 -
 ...1-use-ASN1_STRING_get0_data-accessor.patch |   45 +
 .../recipes-tpm1/trousers/trousers_git.bb     |    1 +
 ...TRING-and-X509_NAME-access-for-OpenS.patch |   95 +
 .../tpm2-openssl/tpm2-openssl_1.3.0.bb        |    4 +-
 ...eturn-NULL-for-twist-on-auth-failure.patch |   28 -
 ...-pkcs11_1.9.2.bb => tpm2-pkcs11_1.10.1.bb} |    3 +-
 .../{tpm2-tools_5.7.bb => tpm2-tools_5.8.bb}  |    4 +-
 ...-disabling-of-digest-sign-operations.patch |   48 -
 ...OpenSSL-function-signatures-that-cau.patch |   78 -
 .../tpm2-tss-engine/tpm2-tss-engine_1.2.0.bb  |   40 -
 .../lynis/{lynis_3.1.6.bb => lynis_3.1.7.bb}  |    2 +-
 ...Python-2-C-API-macros-for-SWIG-4.5.0.patch |   87 +
 .../{openscap_1.4.3.bb => openscap_1.4.4.bb}  |    5 +-
 ....1.80.bb => scap-security-guide_0.1.81.bb} |    0
 .../0002-Support-build-with-nettle-4.patch    |   53 -
 .../aide/{aide_0.19.3.bb => aide_0.19.4.bb}   |    3 +-
 recipes-ids/crowdsec/crowdsec-go-mods.inc     |  408 ++-
 recipes-ids/crowdsec/crowdsec-licenses.inc    |  321 +-
 .../{crowdsec_1.7.7.bb => crowdsec_1.8.1.bb}  |    2 +-
 ...Makefile-drop-running-scrips-install.patch |    7 +-
 .../0002-Makefile-don-t-set-uid-gid.patch     |    7 +-
 .../files/0003-Add-OpenSSL-4.0-support.patch  |  167 +
 ...ssec-hids_3.7.0.bb => ossec-hids_4.3.0.bb} |    5 +-
 recipes-ids/suricata/suricata-crates.inc      | 2995 ++++++++--------
 .../{suricata_8.0.4.bb => suricata_8.0.6.bb}  |    2 +-
 ...ccs-tools_1.8.9.bb => ccs-tools_1.8.14.bb} |    6 +-
 recipes-scanners/clamav/clamav-crates.inc     |  556 ++-
 recipes-scanners/clamav/clamav-git-crates.inc |    7 +-
 .../{clamav_1.4.4.bb => clamav_1.5.4.bb}      |    7 +-
 ...ed-OpenSSL-accessors-for-ASN1_STRING.patch |  122 +
 .../files/0001-Disable-abort-on-panic.patch   |   24 +
 .../0002-Update-crate-dependencies.patch      | 3177 +++++++++++++++++
 .../krill/files/panic_workaround.patch        |   16 -
 recipes-security/krill/krill-crates.inc       | 1298 ++++---
 .../{krill_0.12.3.bb => krill_0.16.0.bb}      |    9 +-
 .../0001-fix-ftbfs-with-OpenSSL-4.patch       |   53 +
 recipes-security/ncrack/ncrack_0.7.bb         |    4 +-
 52 files changed, 6905 insertions(+), 3459 deletions(-)
 rename dynamic-layers/networking-layer/recipes-security/sssd/{sssd_2.10.2.bb => sssd_2.13.1.bb} (98%)
 delete mode 100644 meta-tpm/recipes-tpm1/openssl-tpm-engine/files/0001-create-tpm-key-support-well-known-key-option.patch
 delete mode 100644 meta-tpm/recipes-tpm1/openssl-tpm-engine/files/0002-libtpm-support-env-TPM_SRK_PW.patch
 delete mode 100644 meta-tpm/recipes-tpm1/openssl-tpm-engine/files/0003-tpm-openssl-tpm-engine-parse-an-encrypted-tpm-SRK-pa.patch
 delete mode 100644 meta-tpm/recipes-tpm1/openssl-tpm-engine/files/0004-tpm-openssl-tpm-engine-change-variable-c-type-from-c.patch
 delete mode 100644 meta-tpm/recipes-tpm1/openssl-tpm-engine/files/openssl11_build_fix.patch
 delete mode 100644 meta-tpm/recipes-tpm1/openssl-tpm-engine/openssl-tpm-engine_0.5.0.bb
 create mode 100644 meta-tpm/recipes-tpm1/trousers/files/0001-tspi_asn1-use-ASN1_STRING_get0_data-accessor.patch
 create mode 100644 meta-tpm/recipes-tpm2/tpm2-openssl/tpm2-openssl/0001-Fix-ASN1_OCTET_STRING-and-X509_NAME-access-for-OpenS.patch
 delete mode 100644 meta-tpm/recipes-tpm2/tpm2-pkcs11/files/0001-src-lib-tpm-return-NULL-for-twist-on-auth-failure.patch
 rename meta-tpm/recipes-tpm2/tpm2-pkcs11/{tpm2-pkcs11_1.9.2.bb => tpm2-pkcs11_1.10.1.bb} (91%)
 rename meta-tpm/recipes-tpm2/tpm2-tools/{tpm2-tools_5.7.bb => tpm2-tools_5.8.bb} (83%)
 delete mode 100644 meta-tpm/recipes-tpm2/tpm2-tss-engine/files/0001-Configure-Allow-disabling-of-digest-sign-operations.patch
 delete mode 100644 meta-tpm/recipes-tpm2/tpm2-tss-engine/files/0002-Fix-mismatch-of-OpenSSL-function-signatures-that-cau.patch
 delete mode 100644 meta-tpm/recipes-tpm2/tpm2-tss-engine/tpm2-tss-engine_1.2.0.bb
 rename recipes-compliance/lynis/{lynis_3.1.6.bb => lynis_3.1.7.bb} (96%)
 create mode 100644 recipes-compliance/openscap/files/0002-Replace-removed-Python-2-C-API-macros-for-SWIG-4.5.0.patch
 rename recipes-compliance/openscap/{openscap_1.4.3.bb => openscap_1.4.4.bb} (96%)
 rename recipes-compliance/scap-security-guide/{scap-security-guide_0.1.80.bb => scap-security-guide_0.1.81.bb} (100%)
 delete mode 100644 recipes-ids/aide/aide/0002-Support-build-with-nettle-4.patch
 rename recipes-ids/aide/{aide_0.19.3.bb => aide_0.19.4.bb} (94%)
 rename recipes-ids/crowdsec/{crowdsec_1.7.7.bb => crowdsec_1.8.1.bb} (96%)
 create mode 100644 recipes-ids/ossec/files/0003-Add-OpenSSL-4.0-support.patch
 rename recipes-ids/ossec/{ossec-hids_3.7.0.bb => ossec-hids_4.3.0.bb} (98%)
 rename recipes-ids/suricata/{suricata_8.0.4.bb => suricata_8.0.6.bb} (98%)
 rename recipes-mac/ccs-tools/{ccs-tools_1.8.9.bb => ccs-tools_1.8.14.bb} (84%)
 rename recipes-scanners/clamav/{clamav_1.4.4.bb => clamav_1.5.4.bb} (97%)
 create mode 100644 recipes-scanners/clamav/files/0001-Use-non-deprecated-OpenSSL-accessors-for-ASN1_STRING.patch
 create mode 100644 recipes-security/krill/files/0001-Disable-abort-on-panic.patch
 create mode 100644 recipes-security/krill/files/0002-Update-crate-dependencies.patch
 delete mode 100644 recipes-security/krill/files/panic_workaround.patch
 rename recipes-security/krill/{krill_0.12.3.bb => krill_0.16.0.bb} (87%)
 create mode 100644 recipes-security/ncrack/ncrack/0001-fix-ftbfs-with-OpenSSL-4.patch

-- 
2.55.0


