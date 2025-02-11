Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C3C5C021A4
	for <webhook@archiver.kernel.org>; Tue, 11 Feb 2025 19:17:47 +0000 (UTC)
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
 by mx.groups.io with SMTP id smtpd.web11.1800.1739301463343429048
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 11 Feb 2025 11:17:43 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=Cq+Snhae;
 spf=pass (domain: konsulko.com, ip: 209.85.222.174, mailfrom: scott.murray@konsulko.com)
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7c05dc87ad9so284460985a.3
        for <yocto-patches@lists.yoctoproject.org>; Tue, 11 Feb 2025 11:17:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1739301462; x=1739906262; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wphHAitc1nfSlKxamRRIxbDCObX+D0GZzLO234ocEDM=;
        b=Cq+SnhaeZ2V9ELEPGUp8jwMlClFqNokJwOsabeBES/zMgtRH6bfnS/bhy21gA7HGiu
         26BNxkh93bYDK1MvG9b2QL/Cy4hTqezRm3CeBXdBB3Ci9YkWpz2drRpLrrvS4RhhIqgS
         a7WX9DTNJPYWZH3hwYuY8v6t0IgFqeinuLc8I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739301462; x=1739906262;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wphHAitc1nfSlKxamRRIxbDCObX+D0GZzLO234ocEDM=;
        b=RptRPHscq9Z7bKg8/Kcmt+l6xUZuYaC18RTwn7xk5WuQq6X9f4g68n1CIy/fqAZ9mk
         bX2zoPiaDcJxAZSH7I9Z15jMrrBKYTqn8CEdqI14EClhA9b5wXLa+GRTuPfa8JGrvdJ9
         EZzvf7C0l+X125SUgTHpAWe8joUaesybvjEWnminMdID8lR98cuaDvpgvWMg6CMmN5yR
         f4Qah8McOUFK79gryZpi8vLUn7Mmy/kJEXSy5Gc6y4onkYMVT/ytBrqMtZ6rjtbUnepo
         PhRNjBw9kW0Yck1HQuDfe37is/yiuxeRgicl5sD/CGVOYOCwFJmcds3A0TgEYlxAWPqc
         u0OA==
X-Gm-Message-State: AOJu0YyGW+1u7xw+jgMlrlgtft6cgKKZlpCDhNR/kC7LxTIMnEOub8ZD
	BIb3+KHcVjdlT8H6lI2NJgkH0iG+3nD4y10XoI+VJBkEYpGNmS1BwRYDiypCtRqyjMtG5cJnqAW
	8
X-Gm-Gg: ASbGncu8O7BRt1qjQy4oJi6ZaPhMY2T4NAoPma+p5CMkeu5FWCW+2vDUGRa/sYIoiKJ
	0hfQYJWNbWGEhA1TBvF9oviPvBpTQbE67rNmH3cbZFjFDgwoA/fkykjrEpF9G+JpUtlESQ21Iyg
	gKu3mQhcJ84Mlh+atPpiZyNAa0X8X/lbtKvDBn6OyExwRxflHrq8lxlpOQKdLF/zjov7lKHBYbs
	zPF5PmqEB8h6XaUejMFKXvHanWkn4QDObQ86MRknBnz2SNJSjOnJoCAOi/PnG5OBg6aLAGFhPBR
	SAyavxvz8hf6V+bRrkQ1qU1I0x92tphf2P+ciOCV8JSYDsNpXkDz7zn/6wkzWIzfo2M=
X-Google-Smtp-Source: AGHT+IGvJnq5ue+Kqb1Jx8tMWqq/1yFocW7tVOBxTKWhxoAF9FDLStnBfbolFGFbfBDOudxHWHuPHg==
X-Received: by 2002:a05:620a:4015:b0:7b6:c93a:7f2f with SMTP id af79cd13be357-7c06fc693e2mr77157585a.14.1739301462137;
        Tue, 11 Feb 2025 11:17:42 -0800 (PST)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c05e374867sm318561085a.111.2025.02.11.11.17.41
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2025 11:17:41 -0800 (PST)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-lts-mixins][kirkstone/rust][PATCH 02/10] cargo.bbclass: do not install libraries by default
Date: Tue, 11 Feb 2025 14:17:15 -0500
Message-ID: <e7c7660f95136293a022634053a45613116a8860.1739300779.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1739300779.git.scott.murray@konsulko.com>
References: <cover.1739300779.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 11 Feb 2025 19:17:47 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1067

From: Alexander Kanavin <alex@linutronix.de>

'cargo install' only installs executables and examples into the system,
and we should follow that. Libraries are vendored into
build trees from the crate registry and then baked directly into executables.

Neverthless, there's now a condition variable, so individual recipes can
opt into installing libraries if there's a use case for it.

Signed-off-by: Alexander Kanavin <alex@linutronix.de>
Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 classes/cargo.bbclass | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/classes/cargo.bbclass b/classes/cargo.bbclass
index 0829a58..b583f84 100644
--- a/classes/cargo.bbclass
+++ b/classes/cargo.bbclass
@@ -61,9 +61,11 @@ cargo_do_install () {
 	for tgt in "${B}/target/${CARGO_TARGET_SUBDIR}/"*; do
 		case $tgt in
 		*.so|*.rlib)
-			install -d "${D}${rustlibdir}"
-			install -m755 "$tgt" "${D}${rustlibdir}"
-			have_installed=true
+                        if [ -n "${CARGO_INSTALL_LIBRARIES}" ]; then
+				install -d "${D}${rustlibdir}"
+				install -m755 "$tgt" "${D}${rustlibdir}"
+				have_installed=true
+			fi
 			;;
 		*examples)
 			if [ -d "$tgt" ]; then
-- 
2.48.1


