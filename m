Return-Path: <mhalstead@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16FD4CCF9E3
	for <webhook@archiver.kernel.org>; Tue, 11 Nov 2025 08:44:47 +0000 (UTC)
Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com [209.85.217.43])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.13289.1762850680553381592
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 11 Nov 2025 00:44:40 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=FTRS+6FZ;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.217.43, mailfrom: mhalstead@linuxfoundation.org)
Received: by mail-vs1-f43.google.com with SMTP id ada2fe7eead31-5db2a0661e0so2225815137.0
        for <yocto-patches@lists.yoctoproject.org>; Tue, 11 Nov 2025 00:44:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1762850677; x=1763455477; darn=lists.yoctoproject.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=I27bFcCeV5lbTGZVU7Wi9IPHXqV7USearJyWvV451fE=;
        b=FTRS+6FZu1aML1xEOFL5IKz/r7HWQ4XZDiiYXxjw3XtBCQfjV9UVvMOvqAH8kBD6SO
         E1Tzx59R4thdcZ+7H/mPO7RZbz7GyT+b9Jd4+aGN8bZ0KLiT1h2cLteH7TWjpIFYoh9b
         /NiSgXr1KK6L+AiecDXgjPDZBQMabfMCjdf0I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762850677; x=1763455477;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I27bFcCeV5lbTGZVU7Wi9IPHXqV7USearJyWvV451fE=;
        b=v9JR+huTAJINwQpcdhdDPh2oC04an/xk0KWZyjGbfQlvLrvsr3wzSYygX7i3nAymz6
         Z+orv1eDJk/HDLgvFnRkemQMSuMK5oTdH3MgicXAx2pqrj4eFQyBsrbDuVeTCooRjI66
         j5aLjWIP2yxEqR8WKCkO8wG4ZdZ2178BcOTckIGbKQkCNM7MV1xFFJoRW5F8KqpNsp5N
         8Qk3H5ER1I5agWRErH1Mn8M/RxAAA1cYKLErh1EBRbGLfVwlkVyXIOy6hXNC84w5CS/o
         hTD5Ev+JL1OxEIKJH/6HnJgMjOyXZ+5d5QQH6Ay2S0LLMGGGJh5T8Xa9w4WJ2JStiut7
         /m7g==
X-Gm-Message-State: AOJu0YzXBQkB3/5Ldtr3ClD4khyCJRZjLifWaFO5qNRo6BCFgAcu5sO6
	2bcfP7+bKQvI9H/+3Wdv90BkXGWxzrPhTOEoWzCGdVuHkAxIKRAEgJTsTKJb5uKEtuGmqriFd47
	RCLIPe3gcCPt31Jt0jgdNqDTa18UAx6TDERemLHV25K3lETktaYZNiMI=
X-Gm-Gg: ASbGnctNRrBIX49cswxRX1R0nU0sawbs+kDKFz7Q7XU89FOIhX4uLGchavSfsiEyfjM
	pqKso/5H/fUic7yH/CzW40XCQ35vFz13nAdnzkwNi4H+qaWqWdzFAhFJQXYmizMaoqE8mWXkI3L
	IR2PLp2DXRNtQctkFvEhmfeascJsA+nnVpP85DmbfTi2zZuzKyBqXivKW/PRZXgQJoWLogMRBl1
	3GSvJCH625Tgnx8+5P5svPzKKiGXuQAAux+KUWB4MXvmTErwZDhYijLJMow7sl+hVcHDQPK2w==
X-Google-Smtp-Source: AGHT+IFcxMZqLewG2QZnA0nxbaRwcXIHHMx9ny1t+WJi6jDacded5ObfDzkq+7tKb8sDbyhrdFKyDxn8+7AB1F79zy4=
X-Received: by 2002:a05:6102:94c:b0:5db:d07c:2199 with SMTP id
 ada2fe7eead31-5ddc4814cf6mr3595785137.45.1762850677358; Tue, 11 Nov 2025
 00:44:37 -0800 (PST)
MIME-Version: 1.0
From: Michael Halstead <mhalstead@linuxfoundation.org>
Date: Tue, 11 Nov 2025 00:44:17 -0800
X-Gm-Features: AWmQ_bnBfmF1TLmjA4rLjz61cd7j8WYbdh4z0pU0yZTK4LeHbZ4pp-ciuh38WGI
Message-ID: <CADfgfoZh_6cw3YnapQR3DfrWah3Prp1aj6-d5tJW_jJN5u28CQ@mail.gmail.com>
Subject: [yocto-autobuilder2] config: add fedora 43 workers
To: yocto-patches@lists.yoctoproject.org
Content-Type: text/plain; charset="UTF-8"
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 11 Nov 2025 08:44:47 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2481

Signed-off-by: Michael Halstead <mhalstead@linuxfoundation.org>
---
 config.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/config.py b/config.py
index 2dd36d9..9221c2c 100644
--- a/config.py
+++ b/config.py
@@ -164,7 +164,7 @@ web_port = 8010
 # List of workers in the cluster
 workers_ubuntu = ["ubuntu2204-vk-1", "ubuntu2204-vk-2",
"ubuntu2204-vk-3", "ubuntu2204-vk-4", "ubuntu2404-vk-1",
"ubuntu2404-vk-2", "ubuntu2404-vk-3", "ubuntu2504-vk-1",
"ubuntu2510-vk-1"]
 workers_centos = ["alma8-vk-1", "alma8-vk-2", "rocky8-vk-1",
"alma9-vk-1", "alma9-vk-2", "stream9-vk-1", "rocky9-vk-1",
"rocky9-vk-2", "rocky9-vk-3"]
-workers_fedora = ["fedora39-vk-1", "fedora39-vk-2", "fedora40-vk-1",
"fedora40-vk-2", "fedora40-vk-3", "fedora40-vk-4", "fedora41-vk-1",
"fedora42-vk-1"]
+workers_fedora = ["fedora39-vk-1", "fedora39-vk-2", "fedora40-vk-1",
"fedora40-vk-2", "fedora40-vk-3", "fedora40-vk-4", "fedora41-vk-1",
"fedora42-vk-1", "fedora43-vk-1", "fedora43-vk-2"]
 workers_debian = ["debian11-vk-1", "debian11-vk-3", "debian12-vk-1",
"debian12-vk-2", "debian12-vk-3", "debian12-vk-4", "debian12-vk-5",
"debian12-vk-6", "debian12-vk-7", "debian12-vk-8", "debian12-vk-9",
"debian13-vk-1","debian13-vk-2"]
 workers_opensuse = ["opensuse155-vk-1", "opensuse155-vk-2", "opensuse156-vk-1"]

-- 
2.51.1


-- 
Michael Halstead
Linux Foundation / Yocto Project
Systems Operations Engineer

