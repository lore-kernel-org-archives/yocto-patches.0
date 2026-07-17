Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3C4DC4451C
	for <webhook@archiver.kernel.org>; Fri, 17 Jul 2026 13:19:50 +0000 (UTC)
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.13307.1784294387473771494
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 17 Jul 2026 06:19:48 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=f31a3feX;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.42, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-475881b9a4bso4464115f8f.3
        for <yocto-patches@lists.yoctoproject.org>; Fri, 17 Jul 2026 06:19:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1784294386; x=1784899186; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=I0CoBAZWSP5J4tCI0fyjAebZXBZIlx3CTO/n6aVhtDU=;
        b=f31a3feXkoK8gyK1enw2IuO7D6O+yZJa7NTIgMZFXjhGNDCW7plV/q1fDctatcM9d+
         yle0oUOj1rSYrON4A0rqs7XabLa5BkmD1+uRe/euUabckWTAiVANXuLS1ZuxXF4AnSg8
         pBlKhqbWCdDhFu+d0BunlFYLYNvI5iPDiwPPs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784294386; x=1784899186;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=I0CoBAZWSP5J4tCI0fyjAebZXBZIlx3CTO/n6aVhtDU=;
        b=OOz+cfz08jyD7Yzrr/OUJNS1nG+4DIgAvgYYzcbWA5TdrOVvcX87nRacnSRvRVYFSb
         HBWZROatNx5rDo2h9DcrPJh3og2rLAsBlrCZzI86BNrK1FXQr9neuFH0gkYJi/JAqqc4
         okPlb47o4QShRs9bPYMyOb/s8ujnLUndpBpeHXnITKf5mphEtoQ1b53vN1xF6ugrOyJ7
         MfLbyNc7pixFV9sC/sMIm30cjbsyz35vfRjXp67iWKSXIypSldKPZPT111Sc9El2GGFL
         Tp4zzCXDnuutmEAheRAg/JAuYq9W75F4RwsZJkGTfHGD4nDJDveIm7xzW/6dZNuFS1FX
         mv4w==
X-Gm-Message-State: AOJu0Yy5YoYSzbCCgMb4DMkYa940ckEGJszBNY4L1O5nPk4RZAJmehAU
	yw7u83RWnDG8hxTvrucNbshsg1Qr22KFMdWGbBpHYXoKDXTHqEFl9J8HwDmAfMf6ZASLh7A/YTC
	N0f+qwPw=
X-Gm-Gg: AfdE7cl7tZMD1VRKaLS17sBFJUn7Jx0QnhyRiDcsIhwOyWHa5fAZaJTdGATdDQt3dwc
	stKhjPhclZtOPGogJgdYoY6wiycOmlYGmmRLkVzmiHMnNOPpZTadAOfhL2t7EU9wI92VYPiJwOo
	aLkuXZyWsi4Cd3/r1ZbaCNTTzDGAwxuE178TlX3sonJwLEU8kwlyT4q2xBjyKtFzbsQePaxGCBO
	bZZFhXhR2XFRix9NGuOU8x2hcl8Wwy8V1S9AsgaFXN2eQrHi5PqME3aVoEsMNQUVIvT0apcBh1u
	t3imr744zwp9hw+iEyrbNJM1BIyLvbk0sAqD5WARCEUUU7is3XvKHgPpkFkwxwv0CSAUwVsvnMz
	9+O8XfBiU69OP/HsI/mOgf/jT1iZ9FryaLpCr25//IWgQhxglidzEVasHQ51rAscuTXsurZuP3k
	C5nmpboGNK5+TBQ8R4telkR0eRj2Dnvg==
X-Received: by 2002:a05:6000:228a:b0:46f:f12b:e45a with SMTP id ffacd0b85a97d-47f622fe81bmr3889910f8f.23.1784294385544;
        Fri, 17 Jul 2026 06:19:45 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:4f8:d22a:f372:6bf7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f63eea8afsm4074701f8f.33.2026.07.17.06.19.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 06:19:44 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: yocto-patches@lists.yoctoproject.org
Cc: seebs@seebs.net,
	mark.hatle@kernel.crashing.org
Subject: [pseudo] [PATCH] linkat: Fix AT_EMPTY_PATH handling
Date: Fri, 17 Jul 2026 14:19:43 +0100
Message-ID: <20260717131943.3386262-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 17 Jul 2026 13:19:50 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4500

Currently we don't cover the case where AT_EMPTY_PATH is set for atlink.
Update the code to handle this case in a similar way to the /proc/self
case which is similar.

This is used by some systemd tools which OE might run at rootfs time
such as hwdb generation.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 ports/unix/guts/linkat.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/ports/unix/guts/linkat.c b/ports/unix/guts/linkat.c
index 60fbf63..36ffc0f 100644
--- a/ports/unix/guts/linkat.c
+++ b/ports/unix/guts/linkat.c
@@ -35,13 +35,18 @@
 	}
 #endif
 	oldpath = oldname;
-	if (pseudo_chroot_len && !strncmp(oldpath, pseudo_chroot, pseudo_chroot_len) &&
+	if (oldpath && !*oldpath && pseudo_chroot_len && !strncmp(oldpath, pseudo_chroot, pseudo_chroot_len) &&
 		oldpath[pseudo_chroot_len] == '/') {
 		oldpath += pseudo_chroot_len;
 	}
 
 	newpath = pseudo_root_path(__func__, __LINE__, newdirfd, newname, AT_SYMLINK_NOFOLLOW);
 
+	if ((!oldpath || !*oldpath) && (flags & AT_EMPTY_PATH)) {
+		tmpfile_fd = olddirfd;
+		// call actual link
+		rc = real_linkat(olddirfd, "", AT_FDCWD, newpath, flags);
+	} else
 	/* weird special case: if you link /proc/self/fd/N, you're supposed
 	 * to get a link to fd N. Used in conjunction with opening a directory
 	 * with O_TMPFILE in flags, which actually opens an already-deleted

