Return-Path: <rtrivedi@snap.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBE24FF886C
	for <webhook@archiver.kernel.org>; Tue, 28 Apr 2026 21:45:12 +0000 (UTC)
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.658.1777412705436603374
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 28 Apr 2026 14:45:05 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@snap.com header.s=google header.b=eTueH9Rk;
 spf=pass (domain: snapchat.com, ip: 209.85.210.170, mailfrom: rtrivedi@snapchat.com)
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-82f83bd32efso8747244b3a.2
        for <yocto-patches@lists.yoctoproject.org>; Tue, 28 Apr 2026 14:45:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777412704; cv=none;
        d=google.com; s=arc-20240605;
        b=fQ60eK7v2RjuPN5qjNk5kqGgcRTqDxGdNa7yg/vNj8iBVBylrkEQnl5G0fwO/5L23s
         9hDFZ9ok8CukSOww/z6xlFNWtCNdOCufjRhqTzMeLoM1gHXrXApBXGyld0GikvC2t8Ma
         daLJxWF8aNLKhdbfnpMiVFY5qwo+Nxr3V04quWfWoK/Q/WrXLUG82HxjaAtLYdR7JcwS
         LfxS/IZ4YS4+PBcEaoI5wffkvzkpks55AKlQfVL/70rO7dE/VIlMp6B25CKLeetz2/68
         hXe/lZyc0HWV/JHAv187k47ai+zCruqdinBf/0DrVAbp+A41vmmed5/k+IPwtgenQOVj
         0wpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=9Xt/NQEziP7pWpdM3l8NoCSlaQf3XIoTT5uDjxFyRMA=;
        fh=/Hpk4tTGaXpdv9l1MBS8cYp4DanNyj1iy3fyB8qCiNw=;
        b=QctPa/HOd2jgY6L8Lr3FsunbawupRrSo+B5U5g9OWY2sl5ksJhgVUxRCF406VZ7RSQ
         7i81rsB3V03RHti0VpOoY/4+AGCe8g5barT33JqJyr9geJbntry4snAc/eaMa1ctzfbH
         5gBOaIiTU/Tpf/PY9soUJqWp2w4MEMnVLP8wfIgqW8rmZZuXZBdSpIweuJkIvCttPL3V
         5r9RA3rsS9kSpni+SpZS144zDV3JqYkPxdrySrKkv+okQw1+qsWTzvOdsrJ/UGwYRU4U
         cm4R1m4nbSiaBMm61u81RP2Xm+WfRq4/U8JfkYOfnQH6e8XuGxQiGk3v1LL1Pci9isIC
         qn8A==;
        darn=lists.yoctoproject.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=snap.com; s=google; t=1777412704; x=1778017504; darn=lists.yoctoproject.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=9Xt/NQEziP7pWpdM3l8NoCSlaQf3XIoTT5uDjxFyRMA=;
        b=eTueH9RkFlx+OnfPykXsOUbsmOtw9l168FC9x+pbw4Chn++vhHeJMjhl9KLhD8pSdc
         BQR/los3zXhV9l65yroEBO0n+vMD0fMAC5oAAgmC9psNIjqhjZgKcH7sE6fhuuJZGXKO
         CMnn9LBnBcdpL4Vjvw3lU4fQAS1E9qDgqXjv4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777412704; x=1778017504;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9Xt/NQEziP7pWpdM3l8NoCSlaQf3XIoTT5uDjxFyRMA=;
        b=o5btYdqW0lVC7X5WGtRN7AHNmOkluEWYyr//6cUPM4WNoPEk3fN+krzHAcIVRmMMj1
         h7ylhHcHTAzhAIbJzqtgyd1mp8BcRfClz+XOizu4heSQwNYX3pOyO+WVrRduY2f5zm34
         naiyMDm9F56xVNh8sN+Nn6EV/EBXOkV7kdrFeB+kiXtgbds6DLRzghhlNPye/Z8t6rKS
         K6YHHBB1/4Yg3K5d52waZkWTXMjcufgrhV93YnXt5OTVvDQsvVFVh3Z5dMOJIax7qkWY
         y14Q72Qjnq2UUkrvj79y/zR8EHWxQk7aeeeNe+V+3zx58U16lGHh44EDVmfh/e2VDTzG
         Xp7g==
X-Gm-Message-State: AOJu0YwkZWCsNpICBGlEopyo8XBuRQ9ialzVrIskRr72bb6BvJneUxg/
	MoFc4iFq81jwZNgpaTe/xFqjjgOiUmWkkPDuIOf7TAJh15YpIy+LtClclFhvE8/f+bm3oj56Dyy
	1GTVkB5u4nAolZLg4upWPTaksDXm9Qtp2kxU4mxaBr6h9gPWmLCy5HHb4WA==
X-Gm-Gg: AeBDievwJ2Dmz5HZBWGO85opuAOW+jxGsC4clrXp7Ux23abvKCDjnS8kUD2Oi1qEPxc
	HaxMpj3WCctRrcV6Qcso/fUnw4ou2KF+R5OMWzfuLkD8XKp894sSk3ZNKlW/uht7Q5cPE1p2rPH
	rVSUoVTrOcFT2b6lmi8Ucrfh/TnBUedgWR3b6zgbrzUFfz65OZwVj/P1gacwOmWz1EBnWOLgOkB
	GhDol3F5OFUZuH5+4ZPHlvJbz7/+l9hBWkL+Jwkhy37AsRuq+yOxDnsuyt8f8n+qsHw1g8g7bPG
	oV3usgxi4vdpHOc=
X-Received: by 2002:a05:6a20:7488:b0:3a2:e8f1:b872 with SMTP id
 adf61e73a8af0-3a3af6475aamr1245826637.27.1777412704168; Tue, 28 Apr 2026
 14:45:04 -0700 (PDT)
MIME-Version: 1.0
From: Rahul Trivedi <rtrivedi@snap.com>
Date: Tue, 28 Apr 2026 14:44:52 -0700
X-Gm-Features: AVHnY4LRTNiuRO6LeSR1ASc0vV3SF1QThPc_HpNFHeRrKdAoCzgN1HEE10L8nk4
Message-ID: <CACoT=N69smMYYP7EfdtySviFkLNhom-_yNjMtv8+5=FCDF5ThQ@mail.gmail.com>
Subject: [meta-mingw][scarthgap][PATCH] gcc-cross-canadian: Disable C++ tools build
To: yocto-patches@lists.yoctoproject.org
Cc: jpewhacker@gmail.com
Content-Type: text/plain; charset="UTF-8"
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 28 Apr 2026 21:45:12 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3871

This disables C++ 20 modules since c++-tools are

needed for that feature to work, this is therefore

an intermediate fix until we fix the c++-tools build

issue which seems to related to it asking for pic

version of libiberty.a which is not generated separately

on x86 unlike other architectures because defaults are

PIC already


Signed-off-by: Khem Raj <raj.khem@gmail.com>

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>

(cherry picked from commit 4ac078fb567ce03d9181fb0480c7bd17dc5ddb5d)

Signed-off-by: Rahul Trivedi <rtrivedi@snapchat.com>

---

 recipes-devtools/gcc/gcc-cross-canadian_%.bbappend | 3 ++-

 1 file changed, 2 insertions(+), 1 deletion(-)


diff --git a/recipes-devtools/gcc/gcc-cross-canadian_%.bbappend
b/recipes-devtools/gcc/gcc-cross-canadian_%.bbappend

index 13ea016..2d4358a 100644

--- a/recipes-devtools/gcc/gcc-cross-canadian_%.bbappend

+++ b/recipes-devtools/gcc/gcc-cross-canadian_%.bbappend

@@ -1,5 +1,6 @@

 INSANE_SKIP:${PN}:append:sdkmingw32 = " staticdev"

-EXTRA_OECONF:append:sdkmingw32 = " --disable-nls"

+# Disable C++-20 modules features as the needed tools do not build for mingw

+EXTRA_OECONF:append:sdkmingw32 = " --disable-nls --disable-c++-tools"

 LDFLAGS:append:sdkmingw32 = " -Wl,-static"

 EXEEXT:sdkmingw32 = ".exe"

 ELFUTILS:sdkmingw32 = ""

--

2.51.0

