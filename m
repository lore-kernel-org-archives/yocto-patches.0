Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FE9AE67805
	for <webhook@archiver.kernel.org>; Mon, 22 Dec 2025 16:52:33 +0000 (UTC)
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.83952.1766422348456845875
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 22 Dec 2025 08:52:28 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=map5S1Vx;
 spf=pass (domain: konsulko.com, ip: 209.85.219.41, mailfrom: scott.murray@konsulko.com)
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-8886fdf674bso47749546d6.2
        for <yocto-patches@lists.yoctoproject.org>; Mon, 22 Dec 2025 08:52:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1766422347; x=1767027147; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BQc3i2VGjtSVdTaK+MoJ7xAqJPNpzG9HKezu7nHg3Ww=;
        b=map5S1Vxx/ZpmhWgj32KhA1R7qtedFkkE6OLAd8xIvwGNlV747ns1tGxpKsUtegtzu
         DzW9dct9UFBt8tSFznm5fGQdefmZ4UZ+QhGkjgAVIxLpfRSWsyPSuilxuYa9KrWBZPBW
         YNr+4HnLqVSqVu4uw037ognMsoK6NG3vtqGPU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766422347; x=1767027147;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BQc3i2VGjtSVdTaK+MoJ7xAqJPNpzG9HKezu7nHg3Ww=;
        b=BE2BZVM4zPokQqPfzMPJ2mlVk/hcAZv30FXmND2qlJ6/uoyEHX7wA2TLpdJvRPpj54
         g1Lj0tleURJG5juYbM7mOnyQ0tEG1hLgSV8lWS1fuPfTzVbnrxvCJiPlp+Cj47d20R8J
         B/vHk9u+hHxksh6vTPKWKtFhMz47STGOYkqUg0kZ0s8EgY1BP+57h5/xdyy2FLOXbn6S
         ASpF/lNT+VZtwAvEGgbsVYKxa7wupQtr8AC/zbFORWUH53kmSC9b7qEpksJUwXFGUAA1
         ZRZ7M4pn9cULrgRbsrJjLemCsBlztmEqOas0mSu33h6obxnzHQ3KJxJ75vjqmQWHbfsz
         VLEA==
X-Gm-Message-State: AOJu0Yx63r3Vn9nCCWAPiKC8kD61VkQP3jBQHAD7kA5jzwueIK+fu756
	msqmj8PJoehQnH5WdGvwYnlb4pGguCicbWJSbNobKVBuCZt12fzhvXHo40gQrNqOK1I4+x/HqnO
	Lr0MJ
X-Gm-Gg: AY/fxX4Ilrx96jKJ/n42i+hINgQOZxLqNqVIUfhxyA7fXFsVQSJKgUVhSqEkwg4+2rb
	/PzDjCcdRmWX0Gt/wH0WXvdZHlkUiMERo67KNz6kdg/Cz6eLXlmBYVQFmr6+P/J455a2vQLGyKK
	Cah2lwjhM88VHSC9xBU0jn2il/AgjIegIKqi0zOgqjrFTweMYA03Fb1PekDkNeaki4GeFgAK6FR
	nmh1c4U2/mhnEFLHKrwXyf/99NqmCqXsgYl8AohGwri8utRY2AcQ2qr8q9Suut1DXgXTLmEFYpp
	3buVkTEeDoiTvb2njjvDBILlZoorBFYxLRL5Cct/dyWhxa+1KMeBQ7N/2qUx4OxN/sX+tVE3mPZ
	HBXYk7cxZtzMT5SWxLkFbjZvRUgyVpPFF71HSX2Lmqvl9YsQuA9kdYMRUaTqVo9jSy1FClJZqW/
	6bxA/uA6QG/i9rSdFaeRrqBhlEfF01t+5XMsytGGTPRl9lt9AVJRIt3KCmCfnC+ES7yI3k3TvM/
	TqO/Vew3CjVcSfUg1wLW4MCYYgz9VtcXusNcmwn7qM6H971VZ9E
X-Google-Smtp-Source: AGHT+IFt05bliqfDe1jlpKFfQ2GbJxOsK0EO2C94bAXAesSK297xouTJUctb51Q5Xn1OMQAs08rfNw==
X-Received: by 2002:a05:6214:3bca:b0:88a:589b:5db5 with SMTP id 6a1803df08f44-88d7f6ac234mr191108036d6.0.1766422347176;
        Mon, 22 Dec 2025 08:52:27 -0800 (PST)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-88d9623fdfdsm87149726d6.5.2025.12.22.08.52.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Dec 2025 08:52:26 -0800 (PST)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Marta Rybczynska <rybczynska@gmail.com>
Subject: [meta-security][PATCH 8/8] suricata: drop deprecated nss, nspr PACKAGECONFIGs
Date: Mon, 22 Dec 2025 11:51:56 -0500
Message-ID: <3b93a09d528fd93995a15c4994de92759b057b15.1766420960.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1766420960.git.scott.murray@konsulko.com>
References: <cover.1766420960.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 22 Dec 2025 16:52:33 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2858

From: Clayton Casciato <majortomtosourcecontrol@gmail.com>

Default add in 3f95047ae1e1d ("suricata: package update to 2.0.8")

https://docs.suricata.io/en/suricata-8.0.1/upgrade.html#id7
As of 7.0, "NSS is no longer required. File hashing and JA3 can now be
used without the NSS compile time dependency."

Removed in 8.0:
https://github.com/OISF/suricata/blob/suricata-8.0.1/ChangeLog#L647

Signed-off-by: Clayton Casciato <majortomtosourcecontrol@gmail.com>
---
 recipes-ids/suricata/suricata_7.0.13.bb | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/recipes-ids/suricata/suricata_7.0.13.bb b/recipes-ids/suricata/suricata_7.0.13.bb
index cfb01c5..0635bf3 100644
--- a/recipes-ids/suricata/suricata_7.0.13.bb
+++ b/recipes-ids/suricata/suricata_7.0.13.bb
@@ -37,7 +37,7 @@ CARGO_BUILD_FLAGS:append = " --offline"
 B = "${S}"
 
 # nfnetlink has a dependancy to meta-networking
-PACKAGECONFIG ??= "jansson file pcre2 yaml python pcap cap-ng net nss nspr "
+PACKAGECONFIG ??= "jansson file pcre2 yaml python pcap cap-ng net"
 PACKAGECONFIG:append = " ${@bb.utils.contains('DISTRO_FEATURES', 'ptest', 'unittests', '', d)}"
 
 PACKAGECONFIG[pcre2] = "--with-libpcre2-includes=${STAGING_INCDIR} --with-libpcre2-libraries=${STAGING_LIBDIR}, ,libpcre2 ," 
@@ -50,8 +50,6 @@ PACKAGECONFIG[nfq] = "--enable-nfqueue, --disable-nfqueue,libnetfilter-queue,"
 
 PACKAGECONFIG[jansson] = "--with-libjansson-includes=${STAGING_INCDIR} --with-libjansson-libraries=${STAGING_LIBDIR},,jansson, jansson"
 PACKAGECONFIG[file] = ",,file, file"
-PACKAGECONFIG[nss] = "--with-libnss-includes=${STAGING_INCDIR} --with-libnss-libraries=${STAGING_LIBDIR}, nss, nss," 
-PACKAGECONFIG[nspr] = "--with-libnspr-includes=${STAGING_INCDIR} --with-libnspr-libraries=${STAGING_LIBDIR}, nspr, nspr," 
 PACKAGECONFIG[python] = "--enable-python, --disable-python, python3, python3-core" 
 PACKAGECONFIG[unittests] = "--enable-unittests, --disable-unittests," 
 
-- 
2.51.0


