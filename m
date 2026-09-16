Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86E48C982D3
	for <webhook@archiver.kernel.org>; Wed, 16 Sep 2026 21:58:50 +0000 (UTC)
Received: from mail-qk2-f28.google.com (mail-qk2-f28.google.com [74.125.230.220])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.26513.1789595929270027908
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 16 Sep 2026 14:58:49 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=JrH1chw/;
 spf=pass (domain: konsulko.com, ip: 74.125.230.220, mailfrom: scott.murray@konsulko.com)
Received: by mail-qk2-f28.google.com with SMTP id af79cd13be357-93910a0cb7aso13264085a.1
        for <yocto-patches@lists.yoctoproject.org>; Wed, 16 Sep 2026 14:58:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1789595928; x=1790200728; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=BXS3o1AtM+HQBKnh0PS5RWvOvPs66qNLbF4lJ/YWNrU=;
        b=JrH1chw/gcFPMYra06RzsJa9uk0MDcP9m7ZvaB+RkMcz5OPi58Q/bDNHxxDKbU8b3C
         7DbAQojT5AS0NeEOQpPGfLi+a6Ji2dp1dISwvZVucINIq/PDXVqOLIU1k8VxsIZ+RimZ
         UYkYhXuVRva41MUPs02TAxjw+VWNVCP0rpfFc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789595928; x=1790200728;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=BXS3o1AtM+HQBKnh0PS5RWvOvPs66qNLbF4lJ/YWNrU=;
        b=LBH2qCmSvQnK0DPCyUlFOMPT0l/L1ntU67W1VDk7/jkD/HuHXMu0shq3D5Po+yvNGc
         cAau47OSPR1Ufi5fIkSRlXqYT8uK08ox8SsEV83BPebJnrVtZcIWkgrB/d4akaR9QojL
         23Q7YM1hEnG8XmEOiVtRSjh+CaXcxZKnjn2k2QgQjd2uX4sQO7hLSXd9Im9nQK1B9x8y
         r7A3oJS+JgdNVMfCbyqBs+R9Cs3XHHk5brhteQA4qJ1VTQgVLsfXQJz2dxD+ay2JMva3
         MsVMoVhYo4Z0FmmtGIZ2a7yytslEYw99dW33l1HigO5zKPjGNu5fANG8WKUUmxbvepRP
         A8Pw==
X-Gm-Message-State: AFuF++l2d0hi8yZDAXohVN0y/dl/508LTiskk/kXd6iRh/uy5WyZ4Yrt
	sWZbFZKPBnVd/p6CuXIs0mZVTphgQDx3k8RQv6RNsDIO4QASN+nkg0oMFVFPbfzTJiS9mZmZ53v
	gCEIA
X-Gm-Gg: AYBFou2y6GGnHB8I1CwUWmkuwvY8Pep0T5WT2uguAPXMdhk0cXmIJdeEDlZSdk3vUOf
	0zaUBVa27jr+zSK8Qm4Ue+1PMxl6HGaSF1CZg3SgIg0xeW/6ZA40xb92lQhbtevTZ9pC8x04jRm
	GlkQ3UC4tD58IDeXEl3n/V4i20cnTHM9ODuVet8CaeHUkCivmok7Y+UxW3w5eShgigkOnRFTHP9
	lQD6RAK7Zwp7pRcOp+Ojblqss67+to18RRyfUXsU9K+cfF9h2/okwzmqcsDoq1l73xrBz29GVO1
	42SvQHO88uLrZNdDvtb9cZIY3kowIEquib9CxqFiAdDbOATxp9CemKHLQqwPAXGo0R/rkzS5FVP
	jsfKjBsHQEgKNtWyvW/1l76BmqQTE9GQNtUAjuTKKzb71jlYtCYigJ9c35kELxM+Qp8Se/0xQL0
	J0UqzjWP4q3kbqkjt6XaEubpU0Z3s6P1YHanwRdWQP2XEUQdJmWdJbdpZkcJqSefzM5ItkmzGjY
	od5/Sq+1tETq6fparL2hW3ZYh8D66YodhD10ZFvXsppEYB6Red+RCI5ADpNs/GUWwPUBwqvELGy
	DQRwuW/t3jVHWQKshNu1OBiRsmvpHsw7B+/o
X-Received: by 2002:a05:620a:2805:b0:93a:2afd:19c7 with SMTP id af79cd13be357-93bb7950040mr742260985a.37.1789595927985;
        Wed, 16 Sep 2026 14:58:47 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93b781def43sm323293085a.16.2026.09.16.14.58.47
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 14:58:47 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-security][PATCH 11/19] trousers: Fix build with OpenSSL 4.x
Date: Wed, 16 Sep 2026 17:58:11 -0400
Message-ID: <f3d7d2e6d4367b270152745be9b9396c0a5dde63.1789595456.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1789595456.git.scott.murray@konsulko.com>
References: <cover.1789595456.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 16 Sep 2026 21:58:50 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4867

From: Khem Raj <raj.khem@gmail.com>

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
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
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
-- 
2.55.0


