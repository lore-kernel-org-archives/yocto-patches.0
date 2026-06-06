Return-Path: <tim.orling@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E31BCD8C88
	for <webhook@archiver.kernel.org>; Sat,  6 Jun 2026 02:51:38 +0000 (UTC)
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.9454.1780714297428234384
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 05 Jun 2026 19:51:37 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=pPuvogI+;
 spf=pass (domain: konsulko.com, ip: 209.85.214.169, mailfrom: tim.orling@konsulko.com)
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2c0c32f6ce1so17715725ad.2
        for <yocto-patches@lists.yoctoproject.org>; Fri, 05 Jun 2026 19:51:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1780714297; x=1781319097; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=ye69q+vJbx3EgleZ+1YjVq8lrsdD4RBRAqJPiwRULzI=;
        b=pPuvogI+OGetHHTpsZ7H7hpezlkLxltJAmU4Y7B005GAMGNJcIHlvUoDDKk4Fh7BdM
         hQBNjFsNpXr0VPjjACQLUucNFbXlQ7RgTN/U8xbQF97mIFNVQKTGWkm8EqQou6Z6mqfh
         4TB3opaVn31SsN2w4zXV9fpFjrQLLvKsau/XA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780714297; x=1781319097;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ye69q+vJbx3EgleZ+1YjVq8lrsdD4RBRAqJPiwRULzI=;
        b=kHduOrQhoAZhh9pW+Dy1sQ+aB+ux4j4ligHPB+Vaxf2KTowpHiUp4yI438cVi3ZGEV
         nwKt+1pzESUd3YGi5AkDvdP81/d+tPFf8kwuDNwoUb4aFOTP00+A2BoLQmz6nAHCi2PI
         QCDzEbobNgkAumCYuNHrS4Jhze5cW8vFNED9VCjecEjw//xzoZqfDwTGJFMCYKI6EGT3
         /Ayr47U6kj5wp7E+iQzuEfLaTYaGRmxtkxR0ckwTUMMKfRQ7TXrDlksatfHeaz+2qMed
         dy+zIn2VW//TIOuE53UhA8eTS2br9OaYQaTYaBlKGS4Y81Se/EY3HGM1ImwdLjrLrGvl
         72Hw==
X-Gm-Message-State: AOJu0YwNaG/zZR5ElP/WTv9/wHl9FmhhGZqOCpcdoSs3xI5aVR8KSdUd
	ztll1K5ab9yA15fLwKGFTMMAIp7Y2pt7ZOb9SbayFQ5gXcV5HKgS/uajivzgn3CTeOXz0l1g00b
	IHxs/
X-Gm-Gg: Acq92OHgVmRy+Oid7zib7ryyZXX4W5QlQGAUJV8Ohjxl3YLB5PF/+e+4CmjvQ2WDlje
	qEsx7QlKlo5e8XADRKTus9HGhHI66nWJ6FCGRmepVILILihEwhsX0v6CUuYkLp7h6pPvjSRkuY6
	tCGHN4+9KCV9kEJ9Hsc3BXP5PPjgjOWrrytf41h88eNtF/DR3la35ajXCRwCf7iRDJqvapML7EW
	XBzBHAtd6pNCR5d5AJwJvJXQWpHgD1/7V/gJCWa4JA/wL0OiFra0LmnO9c6oqHBDsqmgzLpddPk
	m+4b80sZMY9vd2sUDK8nDnC4t7Y/VE4i8loj9fteY097Fl/IdBf1s8c54tiNhQPPWQiqNCFkErS
	7xVoY4Wg6orBpjoNQhBmW0dwKqwY3C3RH7tAw/JfU+d/YjgNkpwl1qmsxyT5IsICMxSxNtVzq0v
	jSzrTmY7Q1CQGJ6LQVrlKY9sAA/XuDB1oXUf1P9Nz1iplzF7vIAMavtUWQj2lgahIxa0fG89exw
	A==
X-Received: by 2002:a17:903:3888:b0:2be:3850:297e with SMTP id d9443c01a7336-2c1e80ee003mr78718805ad.31.1780714296410;
        Fri, 05 Jun 2026 19:51:36 -0700 (PDT)
Received: from localhost (c-98-232-159-17.hsd1.or.comcast.net. [98.232.159.17])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c16609df6esm115258845ad.48.2026.06.05.19.51.35
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2026 19:51:35 -0700 (PDT)
From: tim.orling@konsulko.com
To: yocto-patches@lists.yoctoproject.org
Subject: [yocto-autobuilder2][PATCH v3 0/6] Implement 'containers' jobs
Date: Fri,  5 Jun 2026 19:51:14 -0700
Message-ID: <cover.1780710041.git.tim.orling@konsulko.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sat, 06 Jun 2026 02:51:38 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4155

From: Tim Orling <tim.orling@konsulko.com>

This series builds on top of the patches already merged from v2.

This series contains the 'yocto-autobuilder-helper' patches to enable:
* building, testing and publishing of 'vcontainer-tarball'
  - vcontainer-tests job
* building and pushing containers from:
  - meta-virtualization
* containers are pushed when the push_containers boolean is set in the
  AutoBuilder UI
  - regstries are set with CONTAINER_REGISTRIES variable
* authentication uses local user credentials (e.g. ~/.docker/config.json
  or .../auth.json for podman)
* containers are tagged with PV_MAJOR, PV_MAJOR.PV_MINOR, DISTRO_CODENAME
  and yocto-x.y release (yocto-x.y.z for release builds).

Additional features, such as container signing and attaching SLSA provenance
attestations will come in a future series, once this initial functionality
is agreed upon an stable.

Concerns about the possible infinite loop around the tarball extraction
"while True, try, expect OSError" code [1] are addressed separately [2],
since the original patch has been merged.

This series relies on the resolution of [3] and [4].

[1] https://lore.kernel.org/yocto-patches/02f0c35f16a8a51bbe0e89145353008f67180a84.camel@pbarker.dev/
[2] https://lore.kernel.org/yocto-patches/20260606011918.61582-1-tim.orling@konsulko.com/
[3] https://lore.kernel.org/yocto-meta-virtualization/aiJDIinJWZhO4Jid@gmail.com/T/#t
[4] https://lore.kernel.org/yocto-meta-virtualization/20260604001931.96550-1-tim.orling@konsulko.com/T/#u

Changes in v2:
* Simplify by  merging vdkr-tests and vpdmn-tests into vcontainer-tests
* Simplify by building containers from meta-virtualization:
- Depends on resolution of: https://lists.yoctoproject.org/g/meta-virtualization/message/9826
* Workaround for recent (since Friday May 29, 2026) errors:
  Error: reading blob sha256:<hash>: file integrity checksum failed for "<file>"
  - This is probably related to either sstate changes or recent changes in vcontainer-common...

Changes in v3:
* vcontainer-tarball is installed in jobs that set "vcontainer" similar to "extratools", instead
  of the more global "buildtools" behavior.
* The (rather large amount of) code for pushing containers in run-config is broken out into
  a dedicated run-push-containers script.
* Workaround for pushing containers is moved to run-push-containers. The most recent
  behavior (on top of meta-virt master-next) showed a different error pattern:
  Error: reading blob sha256:<hash>: EOF
  The workaround simply removes all container images from the VM's container-registry before
  importing or pushing new container images. The commit message was reworded accordingly.
* Rather than installing latest versions of pip, setuptools and wheel, silence the pip
  warning with PIP_DISABLE_PIP_VERSION_CHECK=1
* Rather than installing the latest versions of pytest, pytest-timeout and pexpect, install
  from meta-virtualization/tests/requirements.txt (pending).
* Refactor run-vcontainer-tests script to use optargs instead of a mix of positional args
  and env vars.

The following changes since commit 07887d0ace65c873aa929ef31cae52c4c1a8e5c5:

  script/utils: Remove prefix from sha256 parameter if present (2026-06-05 23:41:35 +0100)

are available in the Git repository at:

  https://git.yoctoproject.org/yocto-autobuilder-helper contrib/timo/containers-upstream-v3
  https://git.yoctoproject.org/yocto-autobuilder-helper/log/?h=contrib/timo/containers-upstream-v3

for you to fetch changes up to c21fe441965ef9fd801338f017109592dba8b9e0:

  scripts/run-push-containers: remove all images before push (2026-06-05 18:20:07 -0700)

----------------------------------------------------------------

Tim Orling (6):
  scripts: add vcontainer-tarball setup, integration, and publishing
  config.json: add vcontainer-tarball build target
  scripts: add run-vcontainer-tests for meta-virtualization
  scripts: add container registry push, auth, tagging, runtime selection
  config.json: add 'containers-library' build job
  scripts/run-push-containers: remove all images before push

 config.json                  | 118 +++++++++++++++++++
 scripts/publish-artefacts    |   5 +
 scripts/run-config           |  23 ++++
 scripts/run-push-containers  | 167 +++++++++++++++++++++++++++
 scripts/run-vcontainer-tests | 212 +++++++++++++++++++++++++++++++++++
 scripts/utils.py             |  20 +++-
 6 files changed, 541 insertions(+), 4 deletions(-)
 create mode 100755 scripts/run-push-containers
 create mode 100755 scripts/run-vcontainer-tests

-- 
2.43.0


