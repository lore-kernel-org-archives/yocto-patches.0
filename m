Return-Path: <mhalstead@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA646D43343
	for <webhook@archiver.kernel.org>; Thu, 11 Dec 2025 18:35:24 +0000 (UTC)
Received: from mail-lj1-f194.google.com (mail-lj1-f194.google.com [209.85.208.194])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.16910.1765478120666189867
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 11 Dec 2025 10:35:21 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=PzbWP3Be;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.208.194, mailfrom: mhalstead@linuxfoundation.org)
Received: by mail-lj1-f194.google.com with SMTP id 38308e7fff4ca-37a875e3418so4168421fa.1
        for <yocto-patches@lists.yoctoproject.org>; Thu, 11 Dec 2025 10:35:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1765478118; x=1766082918; darn=lists.yoctoproject.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=IQOytr1NbnHCgj+VxfSfu2uukJqtvraUmWSrnjP70lQ=;
        b=PzbWP3BeASIui+UQvhuq+eZQYM+IAh6lfLWTPMMIwWzN7T2IBKOBFbBrY+UsbuEYY6
         aHwfYi9I5DA7fm3vMEu1FZ+as0rTVThN3tt03QfCnRCpVQznsNdcBolAApsKwaAm1Jek
         gjv2gdIkQvZ9VNgEkqQSWdaefsYPTesXwoxNs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765478118; x=1766082918;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IQOytr1NbnHCgj+VxfSfu2uukJqtvraUmWSrnjP70lQ=;
        b=YGlLitr79wMCtzS1CxTbqVgZHoLNFe2NsJMEa2HIHD8EhY4NLL1/TbxrEuiQxJXwRq
         pLS6Tn0SbnO7MY/GRuU/U5yn7p/zmER4i4NaEuaoo369OWymIlMI7FlPqrcBQAbcFPXr
         n8v22iK3smuFNJJKCNwgT39/J0g6zmO2Lldn9QujOkfrkgiEfzau4QNC654h0fH4rnYt
         esYCQJz9Rpyoz2n+iduKClXYcORIIU7/0zH3LctqvFQRxSb6ArKzVM25jOCwLyarCw2U
         9RC1Z4SO4UQa5DrTpphwv/ifBdDO1VnlEF2ELnghIgPbnMEvy27NL1omcy0XlGkgYWj9
         XrwA==
X-Gm-Message-State: AOJu0Yy5QS7U05U1AvooMMvAw5czqrzSvVsmrEoJ9YHWfBEDArFWcobn
	piwgv8lgF7PBUxiEpKtt8sLsbbLTzXIpLMc64Vs/Nnx2rNRF3m94wgT69zOOynVYfTSMR/fGpmu
	qYoiNR/f7/mawPGkVcVr7dVx4vDXG0svt3YwP5hRjd5e1qQIyzuir5sph11kd
X-Gm-Gg: AY/fxX50iWYtMrltNC+pswshPZW0hQMZ6VZd8sg3+kkWCodYsC0FYUEieLjRImkpfY9
	Uo3xnNdd79XcDUsqY9jjDktzhBpMpFbz+9D3R7Lstmp3mTX90j1DbPH4ix/lQJCU1RhU0VRtSVl
	v11lhVbvhDWdbrBHdYlvgpumAs/eVrbbFpFODrsiPNk80v7A1Ne/kbgNifDB1CQPpKKB+BW42KZ
	iLrVoyLhxluPvbAqx82QKoZDQxGoVIRa72RVsDnovhpWH8lGNdKgtm4/XpgEauTkItDy3xsaqAV
	kZ1ak5x9R2pFzDzEAfY=
X-Google-Smtp-Source: AGHT+IHwAohGWUKn1txBir8n+STYXpZRq5V4FZKu9ZMvA4SW6FjUGyXzoZ0YUZ7wCnJcaQffVrpabSTQ/O3S7Qe92v4=
X-Received: by 2002:a2e:8a89:0:b0:37f:bbe3:3fe9 with SMTP id
 38308e7fff4ca-37fbbe3426dmr13416501fa.32.1765478117568; Thu, 11 Dec 2025
 10:35:17 -0800 (PST)
MIME-Version: 1.0
From: Michael Halstead <mhalstead@linuxfoundation.org>
Date: Thu, 11 Dec 2025 10:35:04 -0800
X-Gm-Features: AQt7F2omOkJPktZd_U-c8JHQyNFuJfCQBpfkW4C2xXDRMUD-ET9L9fsaWYbkwkg
Message-ID: <CADfgfobJCbbvjGO69kHKWu0NJtHqY11Fzx_jarXVXbbR7ezcmw@mail.gmail.com>
Subject: [yocto-autobuilder2] README-Guide: Add yocto_console_view build directions.
To: yocto-patches@lists.yoctoproject.org
Content-Type: text/plain; charset="UTF-8"
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 11 Dec 2025 18:35:24 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2767

Adding directions we use to build for production.

Signed-off-by: Michael Halstead <mhalstead@linuxfoundation.org>
---
 README-Guide.md | 72 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 72 insertions(+)

diff --git a/README-Guide.md b/README-Guide.md
index 69368b9..bee5a1f 100644
--- a/README-Guide.md
+++ b/README-Guide.md
@@ -72,6 +72,78 @@ being triggered:
 export LANG=en_US.UTF-8
 ```

+### 1.2.1) Building and Deploying the Yocto Console View
+
+
+Build the Package on a Workstation
+
+These steps are performed on your local development machine.
+
+**Prerequisites:** You must have **Podman** installed.
+
+1.  Clone the `yocto-autobuilder2` repository and start a container,
mounting the repository into the `/build` directory.
+
+    ```bash
+    git clone https://git.yoctoproject.org/yocto-autobuilder2
+    cd yocto-autobuilder2/
+    podman run -ti --rm --volume .:/build:Z,U node:22 bash
+    ```
+
+2.  **Inside the container**, navigate to the package directory,
install the necessary build dependencies, and build the Python wheel
(`.whl`) file.
+
+    ```bash
+    # Run these commands inside the podman container
+    cd /build/yocto_console_view
+    apt update; apt install -y python3-dev python3-build
python3-setuptools python3-pip
+    python3 -m pip install --break-system-packages buildbot_pkg
+    python3 -m build --no-isolation
+    ```
+
+3.  A successful build will generate a wheel file in the `dist/`
directory. You can verify this by listing the contents of the `dist/`
directory.
+
+    ```bash
+    ls dist/
+    ```
+
+    You should see a file named like
`yocto_console_view-2025.3.12-py3-none-any.whl`.
+
+4.  Once the build is complete, exit the container.
+
+    ```bash
+    # Press Ctrl+D or type 'exit'
+    exit
+    ```
+
+-----
+
+Deploy the Package to the Controller
+
+These steps are performed on the Buildbot controller machine.
+
+1.  First, copy the newly created wheel file from your workstation to
the controller. The file will be located in the
`yocto-autobuilder2/yocto_console_view/dist/` directory on your
workstation.
+
+    *Example filename:* `yocto_console_view-2025.3.12-py3-none-any.whl`
+
+2.  On the **controller**, switch to the `pokybuild` user, activate
the buildbot virtual environment, install the new wheel, and restart
the controller.
+
+    ```bash
+    # Switch to the build user
+    su - pokybuild
+
+    # Activate the Python virtual environment, if not already active
+    . ~/buildbot-venv/bin/activate
+
+    # Install the package you copied over
+    pip install yocto_console_view-2025.3.12-py3-none-any.whl
+
+    # IMPORTANT: Check that the cluster is idle before restarting at
+    # Restart the controller instance
+    buildbot restart ~/yocto-controller
+    ```
+
+The new console view plugin is now deployed and active.
+
+
 ### 1.3) Customizing the Autobuilder Configuration

 Next, we need to update the `yocto-controller/yoctoabb/master.cfg` towards the
--
2.43.0
Michael Halstead
Linux Foundation / Yocto Project
Systems Operations Engineer

