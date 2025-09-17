Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BDDDCAC5A0
	for <webhook@archiver.kernel.org>; Wed, 17 Sep 2025 20:43:15 +0000 (UTC)
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
 by mx.groups.io with SMTP id smtpd.web11.34463.1758141786738853674
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 17 Sep 2025 13:43:06 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=ukrK4PHk;
 spf=pass (domain: konsulko.com, ip: 209.85.222.174, mailfrom: scott.murray@konsulko.com)
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-811dc3fdc11so16407285a.2
        for <yocto-patches@lists.yoctoproject.org>; Wed, 17 Sep 2025 13:43:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1758141785; x=1758746585; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XlylyJYBSYgRSr0PCbRGfviMC8g/FKhtYmLJXp0p9JE=;
        b=ukrK4PHkoygvrEaVBy9dKkCB/u7S0AKO63GdXmiXOZ/pu5Xo88xN7TxOKwTcnDiA4Y
         6n8E+acTLgDQnHMhKVjL/fsNjWxi1OmRSfprq+4YfDTfs0P9Xow5GKOvmDf89T281SCl
         U4ZVPauv0DYtD0sagwIgWzvu0mX4CMF1/W6yc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758141785; x=1758746585;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XlylyJYBSYgRSr0PCbRGfviMC8g/FKhtYmLJXp0p9JE=;
        b=fTOhkI4fK2ESLvuFz1mNkQZ7yQqkXdUbyO6gwtzfbOtSeKkAOkJ4Wtn6gTYk1MXLqe
         4p3tzDHNqhANzVPT+iBkwNcIb6fC717MBJXtZxGfavUGzhWcAjzEcaUZgdWuLwUt52sf
         vPyjJ8pP5q1eL6OYzOaBvw3qYgOMbuqkF6r79gevgM6k9+dfB/a0RY4hvirNCeX5NYa9
         bdcDhqqMlU3l4j+DaM3DmWIOeqJrAkVMsZJkkQ82P5dHrWA4Whb951CJj36cJ2Ea/A7i
         hYPUwsqNRNKxOoK1aKnZyX6vOA+Ulb8ZX9Sj0y57E48rvRkA7KSm4hD3TamGVVIj4gI9
         2Hog==
X-Gm-Message-State: AOJu0YxXG++F1nYd0Kb6zeaMYwfSSaOLo0XZi4MTAAx/7qvrVwjN8j5M
	JgSBcjOnpKRBq7/bKVt+gpoD9Y+L/rRAStyDxU4Y4jqPsHnoQbk5vl1FHhs4XM7gX1iIMA0JzsP
	7iJR5
X-Gm-Gg: ASbGncvN2Zsot5Kslr1W2qfzlRoPdHbrFdGMLkqz9GNiGvs8nryqsSchj1Jakn5nesf
	S+cvvSqgpNHAJUhAQst3P+dzrXHlZz2Qa+i0okLytoK1Cl2TwtZITs72kYJ3xY5FN7966htgL9r
	ZrEfJyEqaXDbmf7l1f97Kch8RoKKC/w9y0HqrSxmZVhI0NB8fDa8Br6GgJBdXIlo4PQbWtvb5fT
	8hWCgXzqode7QLnvDvssd70+EUkCKAyG7FeHRMBEBzMvMdygR14j6iW3r5oberqWpsp6kni8yp7
	d+2SlFcnMYRd3WrHMJ8D6oHkqRQqx9qXDRx57x2/VPBAEqzphdAiPoUvtY020ZTAaXkPec3Ik37
	e3eyb5NCDYQhgw75Eo01xEQYzIQ56qwIQkcS6ERUzA9jxpv5bYRH6i+D1adzbWv7sBOp6wsf+ss
	y2NWEro2zDDxWS8w9y
X-Google-Smtp-Source: AGHT+IEibNu7gDkUpocTR+dWifltXHqXkltjrXsSASAo6Kw7EQrYqRw5iktu6D405sgxk7rxEox4uw==
X-Received: by 2002:a05:620a:c4c:b0:800:fbd9:b3d1 with SMTP id af79cd13be357-8311334b7edmr455655985a.73.1758141785072;
        Wed, 17 Sep 2025 13:43:05 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-836260ccccasm42991385a.10.2025.09.17.13.43.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 13:43:03 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Marta Rybczynska <marta.rybczynska@ygreky.com>
Subject: [meta-security][PATCH 1/5] lib-perl: add a HOMEPAGE. Use CPAN_MIRROR
Date: Wed, 17 Sep 2025 16:42:48 -0400
Message-ID: <883a74b29fd864d5dd8563fc439c7e3dba72483d.1758138771.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1758138771.git.scott.murray@konsulko.com>
References: <cover.1758138771.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 17 Sep 2025 20:43:15 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2208

From: "J. S." <schonm@gmail.com>

Signed-off-by: Jason Schonberg <schonm@gmail.com>
---
 recipes-perl/perl/lib-perl_0.63.bb | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/recipes-perl/perl/lib-perl_0.63.bb b/recipes-perl/perl/lib-perl_0.63.bb
index 6fc44e4..f0d6832 100644
--- a/recipes-perl/perl/lib-perl_0.63.bb
+++ b/recipes-perl/perl/lib-perl_0.63.bb
@@ -4,6 +4,7 @@ directories to Perl's search path so that later 'use' or 'require' statements \
 will find modules which are not located in the default search path."
 
 SECTION = "libs"
+HOMEPAGE = "https://metacpan.org/dist/lib"
 LICENSE = "Artistic-1.0 | GPL-1.0-or-later"
 PR = "r0"
 
@@ -11,7 +12,7 @@ LIC_FILES_CHKSUM = "file://README;beginline=26;endline=30;md5=94b119f1a7b8d611ef
 
 DEPENDS += "perl"
 
-SRC_URI = "http://www.cpan.org/authors/id/S/SM/SMUELLER/lib-${PV}.tar.gz"
+SRC_URI = "${CPAN_MIRROR}/authors/id/S/SM/SMUELLER/lib-${PV}.tar.gz"
 
 SRC_URI[md5sum] = "8607ac4e0d9d43585ec28312f52df67c"
 SRC_URI[sha256sum] = "72f63db9220098e834d7a38231626bd0c9b802c1ec54a628e2df35f3818e5a00"
-- 
2.50.1


