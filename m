Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E812CCD1AD
	for <webhook@archiver.kernel.org>; Thu, 16 Oct 2025 21:22:45 +0000 (UTC)
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
 by mx.groups.io with SMTP id smtpd.web10.1663.1760649761108633729
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 16 Oct 2025 14:22:41 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=IpAanJrY;
 spf=pass (domain: konsulko.com, ip: 209.85.219.42, mailfrom: scott.murray@konsulko.com)
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-87c1f61ba98so10227776d6.0
        for <yocto-patches@lists.yoctoproject.org>; Thu, 16 Oct 2025 14:22:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1760649760; x=1761254560; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EALPpaQVsvx1uMGkDTAH3ni+1zWtqTZtDnD0uPqXfQA=;
        b=IpAanJrY2jeIlK+LT06n8R7pg0/tRo16VWMQnniWWMrX9nBIKLKgbiEXSawlDhsWpr
         oKR8D6GdVPVROirOEBzRfBxH+RTjk8IeK8jBVVhueLvJNlp2Kps4Q0SXIXFg5+j6599f
         87VbQFszCWmp+sE5f4x+A7OgSje2ZesYnSljs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760649760; x=1761254560;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EALPpaQVsvx1uMGkDTAH3ni+1zWtqTZtDnD0uPqXfQA=;
        b=Alkn9UT4bB+qPFhM5us5fapPEelaZfeTI3OWNPhec0wpCQlmy0wm5645eA99fiD7Qs
         jUCWBzc8lylwpEf5AkLHO0tXw5885/KwpICzVqJFi0oS8WSus/Jrx2Qf5fu/iF1bXIqS
         YrB3i7H0zzvOJTnDvItMCGkfOlmNY4TuizxWoaob95Q/15Wcby0BA6OBdyrQ4fQjMLrR
         cQcaFbpf5aPlhcCtV073GAlYZfeIBXXfZlBD0oPpCO9gJDGo3oSRFJTrZm/0mnilyMJD
         o0YwwwWrKjY1C3Kb7BjBt97jaS3aoCtYvqO1AfV17B/ULfNt5WpbDtPmxpUuIerKUFqg
         45WA==
X-Gm-Message-State: AOJu0YzhIzbHkKw2K3vKVrgyTIK/KGfiiY43U2/b8vnnouwku2UjLJAb
	8ouRf58+OzUYnQFxyqKlIhshiKvwUhkn5t/mmDNWxRt2PMTZ5uluyso/wXk1B/WcDY4TafAJzvx
	TymI2
X-Gm-Gg: ASbGncvbQeGXZZDnwEnI+6ahD78sr8zDTkHeyDz2kTdHcl8DYmabWUdhjkg7pEEhIIn
	vhfqIVbHTOtFu9ZCoqQtKVnPxgYc+wXzsCJ2QqWNp+CWLSPhJUPnFtxtOgDvoO83o2PKlc1EBew
	toGyJ7Y/dmOs2y1nizHp3Uj/ECW5C/JlbUP0dtTFokdSMLt41IgvCzt2M4dn+lGUjhyElJyrsfe
	tI7aoZxgchMxm1UzkINZRgizsEZZ+mtBoPIxMYw16TjrDppFztSfcMMDo2v/At3+KPJbqyrUEqu
	pG0O+9NbtHjrzHOgwj8z9MgFxEUCNP+lMqGp54EtT0LyJZdhuWyGJF5QpNnIUXfD2DgRkJfQzxl
	6K8Xyz6beSxNBtbRlPOc0J1PbFNu2rd49RF4GCnEKB1tC+3MwJX13HvJETH+SuomQkHo+rW7OFR
	q9QZbgSUjx1YHpvWAKIdvGu1YfTUKCJzrFHJr8zr7S1FF3cTMR2Mlbk8KwJvx5HhM=
X-Google-Smtp-Source: AGHT+IElNGOt8I2kUdV+C57snsoAfaUnKQ+d6ElZvcl6GkaEvu4OSCyMU/RQkY87jheovaoaKtOh0w==
X-Received: by 2002:a05:6214:da5:b0:87c:1d24:7b7f with SMTP id 6a1803df08f44-87c2068520amr24083716d6.23.1760649759520;
        Thu, 16 Oct 2025 14:22:39 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-87c1c2fd4f4sm14647466d6.7.2025.10.16.14.22.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 14:22:38 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Marta Rybczynska <marta.rybczynska@ygreky.com>
Subject: [meta-security][PATCH 08/15] suricata: populate SYSTEMD_SERVICE for service autostart
Date: Thu, 16 Oct 2025 17:22:07 -0400
Message-ID: <b571d65f6b5549b2eebf45dacdcbcec73ab1eb8e.1760648348.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1760648348.git.scott.murray@konsulko.com>
References: <cover.1760648348.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 16 Oct 2025 21:22:45 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2333

From: Clayton Casciato <majortomtosourcecontrol@gmail.com>

https://docs.yoctoproject.org/dev/ref-manual/variables.html#term-SYSTEMD_SERVICE

Before:
root@beaglebone-yocto:~# systemctl status suricata
* suricata.service - Suricata IDS/IDP daemon
     Loaded: loaded (/usr/lib/systemd/system/suricata.service; disabled; preset: disabled)
     Active: inactive (dead)
       Docs: man:suricata(8)
             man:suricatasc(8)
             https://redmine.openinfosecfoundation.org/projects/suricata/wiki

After:
root@beaglebone-yocto:~# systemctl status suricata
* suricata.service - Suricata IDS/IDP daemon
     Loaded: loaded (/usr/lib/systemd/system/suricata.service; enabled; preset: enabled)
     Active: active (running) since Mon 2025-09-22 04:05:08 UTC; 20s ago
 Invocation: 8cfeb29631f443f0830bffeb00975931
       Docs: man:suricata(8)
             man:suricatasc(8)
             https://redmine.openinfosecfoundation.org/projects/suricata/wiki
   Main PID: 268 (Suricata-Main)
      Tasks: 7 (limit: 4915)
     Memory: 36.8M (peak: 37M)
        CPU: 2.222s
     CGroup: /system.slice/suricata.service
             `-268 /usr/bin/suricata -c /etc/suricata/suricata.yaml -i eth0

Sep 22 04:05:08 beaglebone-yocto systemd[1]: Started Suricata IDS/IDP daemon.
Sep 22 04:05:09 beaglebone-yocto suricata[268]: i: suricata: This is Suricata version 7.0.0 RELEASE running in SYSTEM mode
Sep 22 04:05:10 beaglebone-yocto suricata[268]: W: detect: No rule files match the pattern /var/lib/suricata/rules/suricata.rules
Sep 22 04:05:10 beaglebone-yocto suricata[268]: W: detect: 1 rule files specified, but no rules were loaded!
Sep 22 04:05:10 beaglebone-yocto suricata[268]: i: threads: Threads created -> W: 1 FM: 1 FR: 1   Engine started.

Signed-off-by: Clayton Casciato <majortomtosourcecontrol@gmail.com>
---
 recipes-ids/suricata/suricata_7.0.0.bb | 1 +
 1 file changed, 1 insertion(+)

diff --git a/recipes-ids/suricata/suricata_7.0.0.bb b/recipes-ids/suricata/suricata_7.0.0.bb
index f02d343..c36fbf1 100644
--- a/recipes-ids/suricata/suricata_7.0.0.bb
+++ b/recipes-ids/suricata/suricata_7.0.0.bb
@@ -139,6 +139,7 @@ fi
 }
 
 SYSTEMD_PACKAGES = "${PN}"
+SYSTEMD_SERVICE:${PN} = "${BPN}.service"
 
 PACKAGES =+ "${PN}-python"
 FILES:${PN} += "${systemd_unitdir} ${sysconfdir}/tmpfiles.d"
-- 
2.51.0


