Return-Path: <raj.khem@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53F87C79F89
	for <webhook@archiver.kernel.org>; Mon,  7 Sep 2026 04:29:36 +0000 (UTC)
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.27623.1788755366041712426
 for <yocto-patches@lists.yoctoproject.org>;
 Sun, 06 Sep 2026 21:29:26 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=PPX7/ePo;
 spf=pass (domain: gmail.com, ip: 209.85.215.180, mailfrom: raj.khem@gmail.com)
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-cc1b838f9b6so3372685a12.3
        for <yocto-patches@lists.yoctoproject.org>; Sun, 06 Sep 2026 21:29:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788755365; x=1789360165; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=kiwzfZjHoiQTVqcmNYYhqM7LovYE3NClqH/VqVzSFk4=;
        b=PPX7/ePoeNoraTfm0ymqJQMtoyKlvMvzQUAQPpJNorAYJjGMRy+195Bx6nlBPRQ6fC
         J/Qf9pohcP7vIQ8P6kLdk/Bbzhmb4f7cCEVgy9LepHyZ1Vz64AW0nwSj4Y83iIH+XsQ4
         NHbbDZRW0SlLzNFMtn/NzDWYYW8oZKtu0Tb6HSaANZG8O2GgNbTj3kzvqg9AbqwOgiIK
         4zYXcOk0XLRfMj3Mz2DJFX2shKHHHFBx4gDHhqOzPicxJTt5JvoFBJ8xskwQj+S+wDvc
         I2I+zMoRZat2gK18B+QHhsZCA2uHyhpqZp9KCGPJKhUv2StmeBgrRJGgshnUIXjgpr8v
         gI7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788755365; x=1789360165;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kiwzfZjHoiQTVqcmNYYhqM7LovYE3NClqH/VqVzSFk4=;
        b=eZf6S75WcfZDNWCgJ7H7x2jrOya7DDP48M78O44SdlSayAT2z0Lh3T36Kb/KahlzHr
         +rsn3vo8GZagpeWQNYi/cpsyjKpMJ32gLTxajtxsj/14Wq8yvIW+3ymvYMKDDC2SPBZb
         foR0Wue7LlVNK0C8ogPoNlPLsYrk8LoW28VSPdv0rivl2EFTB72JFL48NUjddMY2uvev
         pNVe9JlZ2uMh35+CklSeQJ4NY+qyZjSzT/PB1JhJj3DSytVDNsbg9zPeybXzt3z9GMNh
         UDsgXpnrfZlB7GBLSQWvi/bxhQZmpJtu6Dm6S6pcfdWb8YEZJLiX0MaW95fNO4YnL6vy
         b3fQ==
X-Gm-Message-State: AFuF++kY1DTkyQ8zgs7ryypNkxFVIEZZ86B3EJYwE9uTlcK7xtkJAKZX
	3ILI0hJDKq2nwhXKZACxorDML/hxRXBuOk+3nltArUayfYRFg0Rb1iATxVNudg==
X-Gm-Gg: AYBFou1OM+1HA44zCBuVImTxn2g1YPo1wqO7eFIX+G1kyj+TcjGSlbCSZq1MRhLasug
	i2CBWERXKttKeeAe3tF0WNsStVRaVK3BcEE6KTL58LsRnRDulGrGydtnoIhcm2mLS/dpcd+6Z0e
	Lv0WMmO1R7jeWqEJRSGSp6ZLmx+7BZhdsDMz//J918OInPOHtXfLYLVFb4xKqhVN0Kl3QkjID2M
	DsF6p23Ri1S0hcBD3n8sS4+VTvD9wb/nagbKH0qpPFNXCJzJw/TglgoFB1y4foTO4Xmb1sNhE+n
	4OrB0WXsSjZlsuUgk3hemiFxqUBl9YeV0AMZAacErotkOLGVIfdN50+cxfF7J2C2Ffx27zMDfFF
	Go4mmu48zEfCdqZ30PIVoFlv3NjoEK4XADkq9e4mUVQD/02efWLtqXy26IaEsyag01ipnvXQ3WL
	UefKwsu5ubVaLQUzfCUj6acaMgH6gBiXTvalH5yM05hdfNT5BvYyFDCxGXMwqyADBI0QdKPeVsI
	EcFA5oofETVPOj0kGBPns3kPA8XRZDQXUiE/rEVSS7tPaktg+SCcy9lh9kQuCY5OwLbF+KISgT5
	qZog3unci1PDF6rIOat3NVVxmwTwYtQFtU/WLegDbMzP6b+0nj2r8GA8VxFNHS20PpHZrquZxh3
	vOe/f/L6EywwTfAJZiAjwuaV1yaGcFhYB+6mtbvWA0W78Dw==
X-Received: by 2002:a05:6a20:2d26:b0:3d3:adad:f174 with SMTP id adf61e73a8af0-3da3a0a918dmr33902531637.22.1788755365305;
        Sun, 06 Sep 2026 21:29:25 -0700 (PDT)
Received: from apollo.localdomain ([208.95.233.74])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14324356931sm34901475c88.4.2026.09.06.21.29.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Sep 2026 21:29:24 -0700 (PDT)
From: Khem Raj <raj.khem@gmail.com>
X-Google-Original-From: Khem Raj <khem.raj@oss.qualcomm.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Khem Raj <khem.raj@oss.qualcomm.com>
Subject: [meta-security][PATCH] trousers: Fix build with OpenSSL 4.x
Date: Sun,  6 Sep 2026 21:29:20 -0700
Message-ID: <20260907042920.1478490-1-khem.raj@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 07 Sep 2026 04:29:36 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4738

OpenSSL 4.0 completes the opaquing of struct asn1_string_st, so
src/tspi/tspi_asn1.c no longer builds:

  src/tspi/tspi_asn1.c:240:33: error: incomplete definition of type
      'ASN1_OCTET_STRING' (aka 'struct asn1_string_st')
    240 |    memcpy(rawBlob, tssBlob->blob->data, decBlobSize);
        |                    ~~~~~~~~~~~~~^

Add a patch using the ASN1_STRING_get0_data() accessor, which has been
available since OpenSSL 1.1.0 and is the documented replacement for
reaching into ->data. The rest of the file already goes through
accessors (ASN1_INTEGER_get(), ASN1_OCTET_STRING_set()), so this keeps
it consistent. No functional change.

Signed-off-by: Khem Raj <khem.raj@oss.qualcomm.com>
---
 ...1-use-ASN1_STRING_get0_data-accessor.patch | 45 +++++++++++++++++++
 .../recipes-tpm1/trousers/trousers_git.bb     |  1 +
 2 files changed, 46 insertions(+)
 create mode 100644 meta-tpm/recipes-tpm1/trousers/files/0001-tspi_asn1-use-ASN1_STRING_get0_data-accessor.patch

diff --git a/meta-tpm/recipes-tpm1/trousers/files/0001-tspi_asn1-use-ASN1_STRING_get0_data-accessor.patch b/meta-tpm/recipes-tpm1/trousers/files/0001-tspi_asn1-use-ASN1_STRING_get0_data-accessor.patch
new file mode 100644
index 0000000..9287450
--- /dev/null
+++ b/meta-tpm/recipes-tpm1/trousers/files/0001-tspi_asn1-use-ASN1_STRING_get0_data-accessor.patch
@@ -0,0 +1,45 @@
+From: Khem Raj <khem.raj@oss.qualcomm.com>
+Date: Sun, 6 Sep 2026 20:05:00 -0700
+Subject: [PATCH] tspi_asn1: use ASN1_STRING_get0_data() accessor
+
+OpenSSL 4.0 completes the opaquing of struct asn1_string_st, so reaching
+into ASN1_OCTET_STRING directly no longer compiles:
+
+  src/tspi/tspi_asn1.c:240:33: error: incomplete definition of type
+      'ASN1_OCTET_STRING' (aka 'struct asn1_string_st')
+    240 |    memcpy(rawBlob, tssBlob->blob->data, decBlobSize);
+        |                    ~~~~~~~~~~~~~^
+
+Use the ASN1_STRING_get0_data() accessor instead. It has been available
+since OpenSSL 1.1.0 and is the documented replacement for touching the
+->data member; the rest of this file already goes through accessors
+(ASN1_INTEGER_get(), ASN1_OCTET_STRING_set()).
+
+No functional change.
+
+Upstream-Status: Inappropriate [upstream is dormant; git.code.sf.net
+master is still at 94144b0 "Bumped version to 0.3.15" from 2020-11-03,
+which is the SRCREV this recipe already pins]
+
+Signed-off-by: Khem Raj <khem.raj@oss.qualcomm.com>
+---
+ src/tspi/tspi_asn1.c | 3 ++-
+ 1 file changed, 2 insertions(+), 1 deletion(-)
+
+diff --git a/src/tspi/tspi_asn1.c b/src/tspi/tspi_asn1.c
+index f17ce41..14d216b 100644
+--- a/src/tspi/tspi_asn1.c
++++ b/src/tspi/tspi_asn1.c
+@@ -237,7 +237,8 @@ Tspi_DecodeBER_TssBlob(UINT32 berBlobSize,		/* in */
+ 
+ 	if (*rawBlobSize != 0) {
+ 		if (decBlobSize <= *rawBlobSize) {
+-			memcpy(rawBlob, tssBlob->blob->data, decBlobSize);
++			memcpy(rawBlob, ASN1_STRING_get0_data(tssBlob->blob),
++			       decBlobSize);
+ 		}
+ 		else {
+ 			TSS_BLOB_free(tssBlob);
+--
+2.51.0
+
diff --git a/meta-tpm/recipes-tpm1/trousers/trousers_git.bb b/meta-tpm/recipes-tpm1/trousers/trousers_git.bb
index abbb436..ff3335f 100644
--- a/meta-tpm/recipes-tpm1/trousers/trousers_git.bb
+++ b/meta-tpm/recipes-tpm1/trousers/trousers_git.bb
@@ -16,6 +16,7 @@ SRC_URI = " \
     	file://tcsd.service \
         file://get-user-ps-path-use-POSIX-getpwent-instead-of-getpwe.patch \
         file://0001-build-don-t-override-localstatedir-mandir-sysconfdir.patch \
+        file://0001-tspi_asn1-use-ASN1_STRING_get0_data-accessor.patch \
     	"
 
 inherit autotools pkgconfig useradd update-rc.d ${@bb.utils.contains('VIRTUAL-RUNTIME_init_manager','systemd','systemd','', d)}

