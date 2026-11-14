Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.2818.1794616256792154079
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 13 Nov 2026 16:30:56 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20260707 header.b=wRR4g2VF;
 spf=pass (domain: gmail.com, ip: 209.85.216.46, mailfrom: ticotimo@gmail.com)
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-3ac78f4c10bso783489a91.1
        for <yocto-patches@lists.yoctoproject.org>; Fri, 13 Nov 2026 16:30:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794616256; x=1795221056; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vXupL0ztoOIo/Vj6Rc1jRSQDEp1Xp2+GY0VKbvVJ+eU=;
        b=wRR4g2VF7xHzvZX+YIvURXaEzqaxVBiyANZZ1AkTzsfiL9QfBCbSsa8tixaf4RVMYd
         Srz0/3i+DsKHD8pn6ybR9O1vFOYYF3XubSiF6pLQ6GvfJ2NLr+MKPWPRcccAyHzHc36s
         ejm9g1sp9dIzcvJP/CD0D9UKmpT6qPnFsfs681ByeZEqVDm4MbtFkF0JEpAdSlew4QvT
         IWRhIVR1RDxYek/9UIucoH9+7vrWj96EBjl3lPNVGfE/yxXblta3yszzfYoqDNTCcW1z
         ToGE3YRzN3+Tc76y0tByDsSBzgXFXmmh8g8g3bpZmnrYyivgm9KsfXDc+zyZSwEEz0ra
         4tzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794616256; x=1795221056;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=vXupL0ztoOIo/Vj6Rc1jRSQDEp1Xp2+GY0VKbvVJ+eU=;
        b=gSVkIGP1HHB4r0jnT7R3s51fJ9orxCXDqj8Dbq6SMVmrg8aglNflfxOTsOUt4LNIke
         oYBxibLzZv5QuZKSJaIRL8jLCNzhzR1MHM0j6XWm2ao26yV7FvId8D4I+Q2/CkSZT8or
         x+trcZ77oFbXPI2zbMmYMJPusK7PY9xVzQNefwMJU7oC26W44ddo4eZ4trtcfVEiE3ue
         QmJe7lf1c0eiRfXtKuKJ/clPtXW1FF8eeLrHHlNuu8MK6LzjQ3dkkLoAK/mX13J1uBAX
         cO60OG84uC8NmELVfJgrBvsfCN2Z1F8th1fmPXT7mTyK21m3WDUoquCiGSMp7H788zEM
         /Y0A==
X-Gm-Message-State: APuU4Z/LspswtwklA1qLHVpYJB3kfygNMYQ5McqB31eBCGzI8Tan6kn1
	p61J0qBKFSKuee/lWrcBWokufdTxDPvTO7VqSUb4ZQabKcJUfjbu2bf2lJ/5qWif
X-Gm-Gg: AYBFou09L2dU0lRX7XizfszoG5FFiTFyZ8eVSpQAfuPGR33Z3P5vduGtTMh9JQP3mSK
	P9Ui7lzTucJimMW53ueaCyCOXQ2M6FK1PW2/O/icebRpa4iAVbIOFkiGrDibUAjNXSPxlSbL3y6
	z8idAQ52rNV+byTDGEGfUMOs6LFBBN/4QuaXiCnRHwINTZVYsrjlbyTQidevxK5FodU0avG7fUN
	OEfoVOJdFpVA3G29H8SNoFuYx+knAwpow0iNk4to5eLbZAncrYFGYEpYM17KG6BbmtMSVkL4+9c
	iupYQrXPQkKRlBVVLHRLTF21vShMMvYFcGspnb75C+Rte/HessMr+ihE6kgLkWGcU1XzCkZZppy
	O4t1UuHX9qDSFvPb95wrd+KI+dYNy6c6KPEBcx4AWYEUPPlkGT3z9yXhJDbslEdGt+ow3VtyzXr
	+inE+SjyoXY/i+nM/KidwmQ+5ZuVZ2r9aVSVaKvP/UjvAL3lQAaV3TLJ5q1xH7cMvsUeTAT9Lgl
	+0hxKVJC0zRjSLPPiDJlNPI4/eHiU4EotsfoN6OWOAYsJNCldmGroT4wvE6IQyhd8wptWq+5swx
	7DdAr+7r6wdXNnSdD1Qz7qj2FG18LTrd9nPo0aiYYoyRk+w7IEfWImVeXtXN4w==
X-Received: by 2002:a17:90b:1807:b0:3aa:fdad:7d6c with SMTP id 98e67ed59e1d1-3b1b0ca59a4mr3886517a91.58.1794616256123;
        Fri, 13 Nov 2026 16:30:56 -0800 (PST)
Return-Path: <ticotimo@gmail.com>
Received: from localhost.localdomain ([69.9.132.159])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b1aec63b9bsm6684787a91.12.2026.11.13.16.30.54
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 13 Nov 2026 16:30:54 -0800 (PST)
From: Tim Orling <ticotimo@gmail.com>
X-Google-Original-From: Tim Orling <tim.orling@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Tim Orling <tim.orling@konsulko.com>
Subject: [layerindex-web][PATCH 3/3] Dockerfile: create the task logs directory
Date: Fri, 13 Nov 2026 16:30:41 -0800
Message-ID: <20261114003041.15197-4-tim.orling@konsulko.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261114003041.15197-1-tim.orling@konsulko.com>
References: <20261114003041.15197-1-tim.orling@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Sat, 14 Nov 2026 00:31:04 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5349
Content-Type: text/plain; charset="utf-8"

The docker-compose setups mount a volume at the task logs directory in
layersapp and layerscelery. The image did not have that directory, so
the volume belonged to root, and the Celery worker, running as the
layers user, could not write the task log: an update started with the
Update Layer button failed without any log. Create the directory, owned
by the layers user, so that a new volume takes its ownership.

[YOCTO #15395]

AI-Generated: Claude Opus 5.5
Signed-off-by: Tim Orling <tim.orling@konsulko.com>
---
 Dockerfile | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/Dockerfile b/Dockerfile
index f4d19ab..85918d0 100644
--- a/Dockerfile
+++ b/Dockerfile
@@ -68,9 +68,11 @@ COPY docker/updatelayers.sh ${APP_DIR}/updatelayers.sh
 COPY docker/migrate.sh ${APP_DIR}/migrate.sh
 COPY docker/connectivity_check.sh ${APP_DIR}/connectivity_check.sh
 
-RUN mkdir ${APP_DIR}/workdir \
+# The task logs directory is a volume shared with layerscelery; create it
+# here so that the volume belongs to the layers user
+RUN mkdir ${APP_DIR}/workdir ${APP_DIR}/layerindex-task-logs \
 	&& adduser --system --uid=500 --home /home/layers layers \
-	&& chown -R layers ${APP_DIR}/workdir
+	&& chown -R layers ${APP_DIR}/workdir ${APP_DIR}/layerindex-task-logs
 USER layers
 
 # Always copy in .gitconfig and proxy helper script (they need editing to be active)
-- 
2.56.0

