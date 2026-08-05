Return-Path: <piotr@qbee.io>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E107EC55ABA
	for <webhook@archiver.kernel.org>; Wed,  5 Aug 2026 16:17:33 +0000 (UTC)
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.43940.1785946643905745110
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 05 Aug 2026 09:17:24 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@qbee.io header.s=google header.b=ZDX3B8Pj;
 spf=pass (domain: qbee.io, ip: 209.85.208.169, mailfrom: piotr@qbee.io)
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-39c74c469e8so8725621fa.0
        for <yocto-patches@lists.yoctoproject.org>; Wed, 05 Aug 2026 09:17:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=qbee.io; s=google; t=1785946642; x=1786551442; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TwPdFC0WRcoEPvd7IoOac7q+dZChQc9wzSbcTdHEvms=;
        b=ZDX3B8Pjru1HedzudCb4tJZFlaPzpFizQQCcXJRdzWhQmibhyvx8t9UouX3kIx7t8j
         Q0EhvVf///DulbI6ieYVIh6LK/TCPqAwFgbWThus1A6DKXEX2D63CHixUXzv79UFOeJf
         iIMybNqwYjJNu8AQ2dQzC2mKv6BiTpOY0C2R4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785946642; x=1786551442;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=TwPdFC0WRcoEPvd7IoOac7q+dZChQc9wzSbcTdHEvms=;
        b=fSjNK9P/7X5KDG3fQjF5jMmawaVyDn/4SphiVb0fVdxA1k5TGiHOcWDgKc7XzmyJ2U
         1sWKkao56dcxc+IHyTWFXubnhB1OcIbpG7lF6BPdx7cBq0pQ0usi0lOZmopgRJQf7yp2
         +mk+UvWgu82/OhCP0r2vr/DklUQtJMqxuVkCMs1e7KRw/yBVgKZqYy4sU/PGo0yGXarc
         LxoRXiRYa981RZ3wl8i4qybx3lqXQmlqLwY63G6jRdoOmaKEX8YJbXOhcR6HIjAWhJQr
         v35yfSnr2SNwVz/XSH9MVfUS+KtO1TUBYXF9h7wM2jemsNx3k3cR0AURD0ZtUPLUaslV
         /AfQ==
X-Gm-Message-State: AOJu0YzZMxAsrtGj3+qawPkcx1JvFu3c4T3yn0hLHa4xO7oDsqfdQDfq
	fqXV/MbA5DonDvJLmtCgmqT02i7G83+WRy55K9Jffh58IiL+PBsQCbvO3MnCitT7KbJkw2HgdRr
	AEqlcn60=
X-Gm-Gg: AR+sD11zeSAPGz0kAlBO3Jca3c/JyNJ58rHY5j3q7/dKNiCJOdQ+cYIZIcp5y8WJ8k/
	cmu9Zd0ZQdU8VVV9GHFTLs66HR+oJEkmbOz3w0cn7Bfu+uGjDVcfXhhGknBRG4dFUk4AtUnZ6YS
	yzKaKuwgldoHWad72sJFmLqHBYRWubWSHqQM6wCoMsy8/6vNRZAjtvL3V+DcGelTkJKgZAHA8nr
	akLrXyMEYnuSCVh4T5sbY/PSrtyGu5JMhnv5i6T4G5nLcNWQ8JaXARkhDZX2Sq6M8UnvXqTUyRU
	bf6RCRWqW861zMVUrAe4WgAJW2kRdKoPoehYGsLZHdkxb+nh6wR51eQBIDDPY7vL1t8r9ooPU4T
	+MbqYwAIZwxt4a5wceSAttVbQVNogzMXhm1THa42uA5/xJANLpz2o6DjGknmt3o2Job3s5SzIGC
	0irqTr7KS/4BDTA0ZlfDN2i3cgBS1ombrXb3gi8qfRzAX7DGPzdr1cmgHhaTW3kauBp9actAtrD
	f8s1+Gb5GOrP9XFGQ==
X-Received: by 2002:a2e:a802:0:b0:39f:c7f9:e4b4 with SMTP id 38308e7fff4ca-39fc7f9fd31mr3731451fa.26.1785946641661;
        Wed, 05 Aug 2026 09:17:21 -0700 (PDT)
Received: from localhost (80.89-10-247.nextgentel.com. [89.10.247.80])
        by smtp.gmail.com with UTF8SMTPSA id 38308e7fff4ca-39fb9a576c2sm11394901fa.40.2026.08.05.09.17.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Aug 2026 09:17:20 -0700 (PDT)
From: =?UTF-8?q?Piotr=20Buli=C5=84ski?= <piotr@qbee.io>
To: yocto-patches@lists.yoctoproject.org
Cc: =?UTF-8?q?Piotr=20Buli=C5=84ski?= <piotr@qbee.io>
Subject: [layerindex-web][PATCH] Install BitBake inside DevContainer.
Date: Wed,  5 Aug 2026 18:17:18 +0200
Message-ID: <20260805161718.51061-1-piotr@qbee.io>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 05 Aug 2026 16:17:33 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4637

This change make tools like import_layer.py to work out-of-the-box when
DevContainers are used.

Signed-off-by: Piotr Buliński <piotr@qbee.io>
---
 .devcontainer/devcontainer.json | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/.devcontainer/devcontainer.json b/.devcontainer/devcontainer.json
index 4eb5b22..0642115 100644
--- a/.devcontainer/devcontainer.json
+++ b/.devcontainer/devcontainer.json
@@ -3,7 +3,15 @@
   "dockerComposeFile": "docker-compose.yml",
   "service": "app",
   "workspaceFolder": "/opt/layerindex",
-  "postCreateCommand": "pip install ruff pytest && python3 manage.py migrate",
+  // Clone BitBake into the persistent workdir volume (once) so that `import bb`
+  // works, alongside the usual Python setup.
+  "postCreateCommand": {
+    "bitbake": "test -d /opt/workdir/https___git_openembedded_org_bitbake || git clone https://git.openembedded.org/bitbake /opt/workdir/https___git_openembedded_org_bitbake",
+    "python": "pip install ruff pytest && python3 manage.py migrate"
+  },
+  "remoteEnv": {
+    "PYTHONPATH": "/opt/workdir/https___git_openembedded_org_bitbake/lib:${containerEnv:PYTHONPATH}"
+  },
   "remoteUser": "layers",
   "forwardPorts": [
     8000
@@ -27,6 +35,10 @@
       "settings": {
         "terminal.integrated.defaultProfile.linux": "bash",
         "python.defaultInterpreterPath": "/usr/bin/python3",
+        // Let Pylance resolve `import bb` from the cloned BitBake checkout.
+        "python.analysis.extraPaths": [
+          "/opt/workdir/https___git_openembedded_org_bitbake/lib"
+        ],
         "remote.autoForwardPorts": false,
         "sqltools.connections": [
           {

