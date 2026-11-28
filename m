Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.9694.1795884889754891497
 for <yocto-patches@lists.yoctoproject.org>;
 Sat, 28 Nov 2026 08:54:50 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=IWHLxcSQ;
 spf=pass (domain: konsulko.com, ip: 209.85.128.45, mailfrom: scott.murray@konsulko.com)
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-49d05d51553so62819245e9.2
        for <yocto-patches@lists.yoctoproject.org>; Sat, 28 Nov 2026 08:54:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1795884888; x=1796489688; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=YWGvsZCtKRt5sWxZ5EnuPWvIELiNi25KJrl5xUBHu1Q=;
        b=IWHLxcSQvHjUmi+B1Fv/3XFWnfeTiL219H/dsCg0LlDfZ1n0LzE++oslQi3cPgQsa9
         Y/0JGslKMSr/2xWUQwBtTWUTUK/nj6iKTlKyBrL69fm4lp1RVTpk/Bk5b9gdpUmLklrP
         ++xq/mzjvHfyoyG0ZOnjJlZmR1+vMdkQ+gU+o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795884888; x=1796489688;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=YWGvsZCtKRt5sWxZ5EnuPWvIELiNi25KJrl5xUBHu1Q=;
        b=pO5t2Wjpssv0ooW/GoZOq05jVnFSeq976ndGT8KDMGwpR7uWKAbYWWsMQMnLqZI8yc
         Eg7ibo/0xPgZ9q4Vg0J+oM9XUKC/pBni16kKhblCyO2zbbrjuPwHsXG/ZupA8OSg6sRw
         0hm1147vQucplWSP1us8gK2Nl4jPcE+5JdKw+CswB3Fy57L+wyMOVYGi2J7Ahzonyn+d
         6npEIpZZAoCACDDRPkJ+YqrwGiXVLHEalAr/3cbOzHe+4mJnNXNamJlUZgiZGVNKzE/X
         qf/zJjoRN3YVwpT0edUq4uUGZItekwhM1m5VICuqYVUBJBi3r3tE9Z8ZtpzodQTgs28o
         YtEw==
X-Gm-Message-State: APuU4Z98QtVQeqPyBW8WZPj9sjnpIDq7B+Z0YYKKDtaKPj398N78BGHi
	oIh7m5WHDkSh8afLKVQ5gsZiiLd0rFwqgyChEtdb1xxYeuFvps0OgsESFi0KbWWPDJ7h+RCaCir
	HIAVSs7o=
X-Gm-Gg: AZFdTZesGgtJ0Ev0zmm1Yrc/m2Y96NwpmanndhzfVBqNNJ8iBt5NxfwovD293N1QvDL
	8zrFrLyU1UhIo7RenDZaUPFrsWLMXzstkXSAwIMY64ahSrQw8ha7+MknYDa4ZMzg5xmba3akc+o
	iVfndLsKWWvqsYD46mrxApGZ3ouVn6arMLJf6apQx3vc019BWTQuBWPBuQj0fA4qHuRdXFBrAr8
	PKfHxjzhHn7ogyivdPSzQ2R7WtrbdiP1bwybW0se0CRptM5/gc+xgrBWk+M8MofZBcjz82C7Bv/
	XLzgW9XXB9aV8w0kw5t9vXtEP7HQ9TDI5wcM6q71SoK8NPm3GzlY0dbNhQjOGJ3BRfKJr7CeqXN
	rINarkTS1l6LHchcnFnPU5Iy4fWIc3yQ9YjK75KXV52L/zDpEyeOZWSVoMyrPz8RA523ZccIFME
	Uee30HschC4H4NXJnSLRXzcerI+7/n+oRWAgCky2XTup+jRjacpJlFkW84vewJcGS3hjBGg6XvX
	gqoPHNbkNJF+ygFPW1b/1idYFezg4cpagmxAJp0IUMM+bjyNEvPtfz14mnGRewciHjyUgFpNDkl
	2mFn2ekuWMMK6J+7A/YPZugWgiz3S7hJDRwfY+NhB3WyXOgHPJE4Q/ux+EkWYHnNEfnHNZfjOji
	mQnvqEWtFEiIt2vUtNHcFUyBU7nvwI3fyhtViHvGwSkhhnMkF4cQ=
X-Received: by 2002:a05:600d:1c:b0:4a4:fc8c:cfd9 with SMTP id 5b1f17b1804b1-4bb9de0d5ffmr309383065e9.25.1795884887936;
        Sat, 28 Nov 2026 08:54:47 -0800 (PST)
Return-Path: <scott.murray@konsulko.com>
Received: from tone.k.g (lan.nucleusys.com. [92.247.61.126])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb853ca452sm755951155e9.15.2026.11.28.08.54.47
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Nov 2026 08:54:47 -0800 (PST)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-security][wrynose][PATCH 02/14] ding-libs: update to 0.7.0
Date: Sat, 28 Nov 2026 18:54:20 +0200
Message-ID: <0c68a8ad11b9b4d977ba6382aecdd6eec7e35b72.1795883420.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1795883420.git.scott.murray@konsulko.com>
References: <cover.1795883420.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Sat, 28 Nov 2026 16:55:00 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5572
Content-Type: text/plain; charset="utf-8"

The download URL being used for a ding-libs 0.6.1 tarfile is no
longer valid, so update to 0.7.0 using the actual upstream location
on github.  LICENSE has been updated to add LGPL, as it was missing.

Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 recipes-security/ding-libs/ding-libs_0.7.0.bb | 12 ++++++++++++
 recipes-security/libdhash/ding-libs_0.6.1.bb  | 12 ------------
 2 files changed, 12 insertions(+), 12 deletions(-)
 create mode 100644 recipes-security/ding-libs/ding-libs_0.7.0.bb
 delete mode 100644 recipes-security/libdhash/ding-libs_0.6.1.bb

diff --git a/recipes-security/ding-libs/ding-libs_0.7.0.bb b/recipes-security/ding-libs/ding-libs_0.7.0.bb
new file mode 100644
index 0000000..67a1990
--- /dev/null
+++ b/recipes-security/ding-libs/ding-libs_0.7.0.bb
@@ -0,0 +1,12 @@
+SUMMARY = "'DING is not GNU' helper libraries for SSSD and FreeIPA"
+HOMEPAGE = "https://github.com/SSSD/ding-libs"
+SECTION = "base"
+LICENSE = "GPL-3.0-or-later & LGPL-3.0-or-later"
+LIC_FILES_CHKSUM = "file://COPYING;md5=d32239bcb673463ab874e80d47fae504 \
+                    file://COPYING.LESSER;md5=0ce682cee9e5b35c71c890b0458423f1"
+
+SRC_URI = "https://github.com/SSSD/${BPN}/releases/download/${PV}/${BP}.tar.gz"
+
+inherit autotools pkgconfig gettext
+
+SRC_URI[sha256sum] = "5df2f202f892b4c1a6caf87f0056398a8288b281da9d7e65cd7637978ec20ef3"
diff --git a/recipes-security/libdhash/ding-libs_0.6.1.bb b/recipes-security/libdhash/ding-libs_0.6.1.bb
deleted file mode 100644
index 843850f..0000000
--- a/recipes-security/libdhash/ding-libs_0.6.1.bb
+++ /dev/null
@@ -1,12 +0,0 @@
-SUMMARY = "Dynamic hash table implementation"
-DESCRIPTION = "Dynamic hash table implementation"
-HOMEPAGE = "https://fedorahosted.org/released/ding-libs"
-SECTION = "base"
-LICENSE = "GPL-3.0-or-later"
-LIC_FILES_CHKSUM = "file://COPYING;md5=d32239bcb673463ab874e80d47fae504"
-
-SRC_URI = "https://fedorahosted.org/released/${BPN}/${BP}.tar.gz"
-
-inherit autotools pkgconfig
-
-SRC_URI[sha256sum] = "a319a327deb81f2dfab9ce4a4926e80e1dac5dcfc89f4c7e548cec2645af27c1"
-- 
2.47.3

