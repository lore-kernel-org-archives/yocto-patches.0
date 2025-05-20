Return-Path: <majortomtosourcecontrol@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46752C2D0CD
	for <webhook@archiver.kernel.org>; Tue, 20 May 2025 01:21:08 +0000 (UTC)
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
 by mx.groups.io with SMTP id smtpd.web10.10688.1747704065332796285
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 19 May 2025 18:21:05 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=lmIpY3MS;
 spf=pass (domain: gmail.com, ip: 209.85.166.174, mailfrom: majortomtosourcecontrol@gmail.com)
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-3dc7294716cso8928895ab.2
        for <yocto-patches@lists.yoctoproject.org>; Mon, 19 May 2025 18:21:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747704064; x=1748308864; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=80KUAqA1JgJUHxUAwyGs9MWEBq0i8yt8ucl/RF7yCso=;
        b=lmIpY3MS6mgT0SwHTP0Zbsh9tupwqZU7ZydtItgA+9epskSDSiHz/WfMqZnz0fazVj
         hFYf3ymhKAYqj3l5gTGrEOer1TgaxgYKUd5TGzb77x8zM0l6lRZXXMrfEL67qFM2VRQM
         xY45ogRPo0rIrMfsqU9gRmq/acC5F2U0W+3EwbDtkw2tsZNEws0loM9+6KpPAH3cRT8I
         ksoFOhWlyeJo/nuk4xC6rSyBuOF5kjXXmboK9vQHMXUWwQho5ApwTAPq6eFEAA6q+I41
         7TtAi5ihPn7frM8oljwiboMIXOhf1ROnTQOyrd8sXMcDfUDStbrfu4SGJjBoYzZtBeDq
         LP4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747704064; x=1748308864;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=80KUAqA1JgJUHxUAwyGs9MWEBq0i8yt8ucl/RF7yCso=;
        b=CjFmtafT4Pu6pJz8a/h99tm4/3kML4Dwy6S9rs7CWsqd0GTB0GanjZ5kuM39VN9M1L
         DbnWlZHurLe6FIPIO+d/UcfoRsHsRmBGS+gcDiT1GzQghwjGUYYoZ0K/aye5r0NuEWp+
         cpQH4Dw5mYIs68Hzn0L3DjAWKPKCMHg8M162VnxFTEHOXQdeV80CJ5XDARUpXxLusT4B
         BgwfagRMUVCK0CBW5F4x7xYvWl2p2MZDsKdpwJVWJmjnMbeWVzI/Ix90/+0EAiHgDZ5v
         A7j0SfIxynZ8Q31g/NDdzME0c+Ti5LL7OHSokVxo+VNdC6wid33reaeADfC8hfZnhJI6
         zvVw==
X-Forwarded-Encrypted: i=1; AJvYcCW4sThsANc1T7+JQF86Xk3KkQG4QHctzLv40BagvmqiKB2QY4X/llpD8DsIF5tYmPubfWNoT1XXt+q3DHS3@lists.yoctoproject.org
X-Gm-Message-State: AOJu0YzOGx34VuiRDTCi/IdflzF8hXMdd7G2zqOSHi4nXb0gsDDp60n+
	ZPMNsMJjYged+BpHB+9gSrWHFPSmXLDnPuOfL53KyglRnhP/Ssf4lZ+T
X-Gm-Gg: ASbGncuGk2CviPQXnL0HzBmyhmMAuP7yCVx1ih6Mkp0aTtYS+51oKj/6isD5cIKNfAv
	fooJy3FeCZA9RJE47q/3rhGOGt8rmkH6q9u56ofY9ZQxgSzimBWMp2F+IEysGJ4u6V0jydjj2Sw
	vN2jhxPgpgVLDEMBEDDG0g2da95DWi4c1xX8wD8h4iK4JtJJQ4WH0fkQlG49Sz29p9EKzUfeyxF
	3QeYcW66DwrO6u8sKSu+snnZlrPMOaiXWVRiYjYT7Xf4NrEvDvQxU6oVHoGoahCr5CnKsT7Imda
	jwZc+14gfWmLC8NT4D416GuInbFtCfAylNsgOh26bQz1xyyGzWJQiE7sO+vA7RsFmpKNn+rUG9R
	IkjdO+ZaqvyATuZZdi71mAsaAv0p4BuyimIa7DHM=
X-Google-Smtp-Source: AGHT+IHrgojzBnsZUD24s71ZLSXSkX0c63QVrxjO8K2rAI0Xfg1KhRPCC0cUsYLwzJSjlSqF2t25Ng==
X-Received: by 2002:a05:6e02:160d:b0:3dc:7bc9:5058 with SMTP id e9e14a558f8ab-3dc7bc95214mr6873425ab.7.1747704064393;
        Mon, 19 May 2025 18:21:04 -0700 (PDT)
Received: from [172.26.252.3] (174-29-216-122.hlrn.qwest.net. [174.29.216.122])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4fbcc3d2b93sm1936521173.60.2025.05.19.18.21.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 May 2025 18:21:04 -0700 (PDT)
Message-ID: <52a98110-23a3-4a7d-9c88-c09dede76948@gmail.com>
Date: Mon, 19 May 2025 19:21:03 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: akuster808@gmail.com, yocto-patches@lists.yoctoproject.org,
 chris_larson@mentor.com
From: Clayton Casciato <majortomtosourcecontrol@gmail.com>
Subject: [meta-security][PATCH] suricata: drop pkg_postinst_ontarget systemd
 init
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 20 May 2025 01:21:08 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1566

/var/log/suricata initialization is handled by
systemd-tmpfiles-setup.service, which occurs before services like
suricata

Work towards resolving:
ERROR: [...] do_rootfs: The following packages could not be configured
offline and rootfs is read-only: ['100-suricata']

Added in commit 36d656fe7244 ("suricata: add tmpfiles.d config")

systemd testing:

root@beaglebone-yocto:~# ls -d /var/log/suricata
/var/log/suricata

root@beaglebone-yocto:~# systemctl enable suricata
Created symlink '/etc/systemd/system/multi-user.target.wants/suricata.service' -> '/usr/lib/systemd/system/suricata.service'.

root@beaglebone-yocto:~# rmdir /var/log/suricata

root@beaglebone-yocto:~# reboot now

root@beaglebone-yocto:~# ls -d /var/log/suricata
/var/log/suricata

root@beaglebone-yocto:~# journalctl -o short-iso-precise -u systemd-tmpfiles-setup -u suricata
2025-05-20T00:45:46.450027+00:00 beaglebone-yocto systemd[1]: Starting Create System Files and Directories...
[...]
2025-05-20T00:45:47.041049+00:00 beaglebone-yocto systemd[1]: Finished Create System Files and Directories.
2025-05-20T00:45:47.542976+00:00 beaglebone-yocto systemd[1]: Started Suricata IDS/IDP daemon.
[...]

Signed-off-by: Clayton Casciato <majortomtosourcecontrol@gmail.com>
---
Sponsor: 21SoftWare LLC

 recipes-ids/suricata/suricata_7.0.0.bb | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/recipes-ids/suricata/suricata_7.0.0.bb b/recipes-ids/suricata/suricata_7.0.0.bb
index 910e21e..7331c96 100644
--- a/recipes-ids/suricata/suricata_7.0.0.bb
+++ b/recipes-ids/suricata/suricata_7.0.0.bb
@@ -133,9 +133,7 @@ do_install () {
 }
 
 pkg_postinst_ontarget:${PN} () {
-if command -v systemd-tmpfiles >/dev/null; then
-    systemd-tmpfiles --create ${sysconfdir}/tmpfiles.d/suricata.conf
-elif [ -e ${sysconfdir}/init.d/populate-volatile.sh ]; then
+if [ -e ${sysconfdir}/init.d/populate-volatile.sh ]; then
     ${sysconfdir}/init.d/populate-volatile.sh update
 fi
 }

