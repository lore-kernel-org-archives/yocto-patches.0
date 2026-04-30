Return-Path: <rtrivedi@snap.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C173AFF8875
	for <webhook@archiver.kernel.org>; Thu, 30 Apr 2026 00:56:52 +0000 (UTC)
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.10423.1777510604882767757
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 29 Apr 2026 17:56:45 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@snap.com header.s=google header.b=Yjzlx7Kd;
 spf=pass (domain: snapchat.com, ip: 209.85.215.175, mailfrom: rtrivedi@snapchat.com)
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-c70ea5e9e9dso122254a12.1
        for <yocto-patches@lists.yoctoproject.org>; Wed, 29 Apr 2026 17:56:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777510604; cv=none;
        d=google.com; s=arc-20240605;
        b=CgaaXdPJNchFsAZUAfStvsvbeDHfDr5qnZH0Kmrk1+GzO3+8/pC1HPu09Q3on7PRHX
         /yRr7ZOuGen90We8nnzya/ADH1jur3TOFhhIGaTEUGjXUrMc+VqzS3yPlSMdzr1dXVmr
         Lz6fROQcxK3MRZYyBqf7/S4fu5Rlyzzw04KF+Sl9VWr45j5HkvtuE00apZpXN6LG5+YV
         5jUCeTgfuYU2Wj4Awa4Fy4FLDYbWrddkDtixOs71HEZIGgHOh7yTmEKixU9tN8jObjri
         oDpUVcgP8DmeofLdcmpMLAsDaOixk4c8c5Pt/wGdrp+ft03Ep4eD2bJKK9ksu+ps8/BB
         nvqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=hx1z2DZxcN5ZjlBvM02zdEl/H+yi6+ZDC53ttaoS2Bs=;
        fh=/Hpk4tTGaXpdv9l1MBS8cYp4DanNyj1iy3fyB8qCiNw=;
        b=VE7MhAtW+RS/JGTvakXcTMS9ulRZpBljgfsWO3fbftYGj0U5+nJjXSGUGj7xo+t/U6
         JkSVgHYAvyDjKmGv4xtoOq/ZtDk/fdgq1fSsr4I6nVg+xZtr95KoLGCSBA4AimRdyjLs
         98TlJsDKgLy7obzUM+f5HMwoewIuAukeGj9UqterSWqlvInQZXTfLmbKgyCcQZ8rwPyT
         nQMH3dod0/t3S3KPGh7d0neCnVyTkmGmpTTU8FigIYbWK3GqpV7ti+osagjAD2zW4VNX
         dtbFATvCVuk/rr3AuLUyo0Qu9pOFwFeb5KQH83ye7+MTuoXxaEl5Omukzpiy8IBxBO0e
         BA8Q==;
        darn=lists.yoctoproject.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=snap.com; s=google; t=1777510604; x=1778115404; darn=lists.yoctoproject.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=hx1z2DZxcN5ZjlBvM02zdEl/H+yi6+ZDC53ttaoS2Bs=;
        b=Yjzlx7KdM5JNDvh1cmRqAWsYfiAprgyFPuFoG2gxebsHHDnAcmUunuRRSZR0r+2oPe
         pE+Mh0x+S7nz/l18TyXyob+gjNbS6djl7qhgQ87T+pxU5OeMsHsCnDUcVw9NZLb9sZuB
         6QdSPVUSibwlrzDy6NgavqzbBhmAROjniO+N4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777510604; x=1778115404;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hx1z2DZxcN5ZjlBvM02zdEl/H+yi6+ZDC53ttaoS2Bs=;
        b=qD5mTYw2FzY2WsYT0XSNju+z8/L3suIFrmTfhTrlT00xeG14wYFkyAY6HGGDASAcSc
         moSXVFfS5pwoPUiaNiFKVDypU/C36qe+ARAA0A7qduiWXAA/B7b1cHA1gGv75wFzusro
         vMEqC+e5sOGYMdsi/kQV9l7UK73uCkuY9Vz57VYbDiIRBRTuEnDDoH/tAWx8/esWYjd6
         kXbcGe64de3YLA20EAbVR9KuoevJyb5IMtARhcU20sVgq0NxoTCRAFk8LyETlKmHi9B9
         +DamYTyq9Tc+CuruuMvgJcPen0yJXGUvi83tBcwdQfbqIO0aSnDicxza0JotPEoSNaQ+
         JQBQ==
X-Gm-Message-State: AOJu0Yw8jefRIAGINkSpvXgzBiuZEkMpdcUR9sm0jG/V5i9hlaXRPC1c
	yiMvvhVxvE4p48jYv/ysmM+2OQ4vYxB+ZlBFt9vClc6kTrQido1BO2eyPBxCXKBZmMmrDzZb7vm
	zbidgPrrwo5cFIkDQw/cvGjSbEAxf5kZt4rKS8jAUKMYc2H3truJJXV/ssQ==
X-Gm-Gg: AeBDiesHaqk6htjcaaCyipooHQQfOKDrxNeLxgtBR5az+yrmxOOlFE/D9uA4/VRuy92
	H1XNRxHFMidjve5a+nM1Y82rja4I9QVYwAzqS5SawFMQZAY+gWmotU+49ptBKRnidVT3piARvlL
	rNt5chzZMkaFG4oxHSc28jJn7iA1U2/vHvfGRnWDCdC8UY5Ww5fN9IUWQVofpmLy7UfQfGD0aVd
	1zuSv6yV5Pt3pYwnaM8clJwS1uVuNFRTER0vbKVtdZzvooE2qI8q4eor3kqwtyEuyYViKdSLx/E
	fsYyLCW0bpHBwQI=
X-Received: by 2002:a05:6a20:12c9:b0:39f:24a5:3058 with SMTP id
 adf61e73a8af0-3a3cf5eb1e6mr776774637.13.1777510603708; Wed, 29 Apr 2026
 17:56:43 -0700 (PDT)
MIME-Version: 1.0
From: Rahul Trivedi <rtrivedi@snap.com>
Date: Wed, 29 Apr 2026 17:56:33 -0700
X-Gm-Features: AVHnY4KT_rJPJzXWH6Cj0H28hPPKiGInuhs0ECNHhmKQRRYrsnwo5_2Y22dPg_0
Message-ID: <CACoT=N6UZ9xULwNnNOGqmL9pMrhR66dH=cxbb4fj=u836eXQXA@mail.gmail.com>
Subject: [meta-mingw] [PATCH 1/2] binutils: define NAME_MAX for mingw-w64 host build
To: yocto-patches@lists.yoctoproject.org
Cc: jpewhacker@gmail.com
Content-Type: text/plain; charset="UTF-8"
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 30 Apr 2026 00:56:52 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3890

mingw-w64's <limits.h> does not define NAME_MAX, which Poky's backport

of upstream binutils commit d0285cdf58ad (carried as

0017-dlltool-file-name-too-long.patch in scarthgap) uses unconditionally

in dlltool.c.  As a result, building binutils-cross-canadian for an

x86_64-w64-mingw32 host fails with:


    dlltool.c: error: 'NAME_MAX' undeclared


Define NAME_MAX via CFLAGS at the POSIX minimum and NTFS per-component

limit (255) for mingw32 host builds, which avoids carrying a source

patch in meta-mingw.


Signed-off-by: Rahul Trivedi <rtrivedi@snap.com>

---

 recipes-devtools/binutils/binutils_%.bbappend | 5 +++++

 1 file changed, 5 insertions(+)

 create mode 100644 recipes-devtools/binutils/binutils_%.bbappend


diff --git a/recipes-devtools/binutils/binutils_%.bbappend
b/recipes-devtools/binutils/binutils_%.bbappend

new file mode 100644

index 0000000..401bace

--- /dev/null

+++ b/recipes-devtools/binutils/binutils_%.bbappend

@@ -0,0 +1,5 @@

+# mingw-w64 <limits.h> doesn't define NAME_MAX, which Poky's backport of

+# upstream commit d0285cdf58ad (0017-dlltool-file-name-too-long.patch) uses

+# in dlltool.c.  Push the POSIX minimum / NTFS per-component limit via the

+# compile flags instead of carrying a source patch.

+CFLAGS:append:mingw32 = " -DNAME_MAX=255"

-- 

2.51.0

