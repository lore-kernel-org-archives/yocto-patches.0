Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEC4BD1037D
	for <webhook@archiver.kernel.org>; Wed, 26 Nov 2025 04:55:52 +0000 (UTC)
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.6499.1764132949926697113
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 25 Nov 2025 20:55:50 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=M8SeVXqh;
 spf=pass (domain: konsulko.com, ip: 209.85.222.177, mailfrom: scott.murray@konsulko.com)
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-8b2dec4d115so640458785a.0
        for <yocto-patches@lists.yoctoproject.org>; Tue, 25 Nov 2025 20:55:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1764132949; x=1764737749; darn=lists.yoctoproject.org;
        h=mime-version:references:message-id:in-reply-to:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DOS/+feYJMjsOvBthMccDaMh2mm1T/czUsUJE54YSSI=;
        b=M8SeVXqhhJI76chztc8TCcN6XdVcEAPv5wNw55B2WvZ4H7yQ0W2mb9gBWUvTvCHeqR
         MfWLq054c5vRT4Jfvesxfw7jRMtfVwWS3hUgnGSBFcVW2cC/WqJnlBv3vylpK8WKAM82
         8MEkAdiWn7fzTkMHmmbd6E2VGTkCkZV4NxdJE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764132949; x=1764737749;
        h=mime-version:references:message-id:in-reply-to:subject:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DOS/+feYJMjsOvBthMccDaMh2mm1T/czUsUJE54YSSI=;
        b=B2eP5H5Vg6SaPR7BuTR/18OSupaZJVCuYog2F/DE6bJ4rVEDqYSAsvYg4JNBSJvIxs
         F5vR7oAmxXxCPLlvSFMv9c1E3clC+O0azcAFdS3ed8V0s+OEWMBfUEKyS4rpFpOadqZh
         ima9919+ZnTHB/EzrE589UYA0ntUA4c1zCoWOyC/ZY/ibRx0JzDUFOnR53hITjcKtYjO
         5QIsutyFbLk9zbppMPJ+jMntLpsJfXAj5gCzEsbwPhZjXQeiKMx42I89OxBubZ8yAbeR
         +K2Uyh5pNgCsKypm8jj7Yshhqg+vOUhseIOZ12yjWc1obgjhh73bupMWGGGNKpgGxskd
         x/RQ==
X-Gm-Message-State: AOJu0Yxr8exq9mXsuVORxs9R1F3L21ZczW3+hq1HhlfBmQ36Cau4F8U5
	/VyJee/BWC0dgjsiMsw0Kw6VgwDC3JUZx+ChI5NHBzRDqhPrGMDaGtk1gxNmvk4glwhgRxBFsaS
	8j0H/
X-Gm-Gg: ASbGncsp3ywk8Mhu9yy8SjsmbVZXCyRU5iD2L1UL4dNe6sxypJCmdnbfd+JFsh4i9Je
	NGJtbyHl+jW3Ql9DItjwtsmD6+Nrab71FqvJFMbeA68bY2cLK9cYCdu9h3gURziqH8/Js6k8jYV
	UcInndABHYbkms0A3t2x8H+bN8wxJ3YjM7rfPZvZNlBSLDB6/QMPpyyi8VptX8Tg0hscOGoUGJv
	rwy9rVAA7p86iR2U53lBEcpBLIA0mYFBWNKu93LK+V8khQ0bbCHWaAaNrWgjcgVrTM28Dq7mtIO
	E0hWKIMQ08h6Y5EIT8CGKiz1lbiGU35lZmUqDG1jPKWrnwTtMA2CouQeDAYOTWkdSqSvzgFtDoY
	7V3MEQCNxL4jUTjuatPxpmPynzTDnZQ6tyNPkKltnZ5Vcb+40InA5z4GWiGOSc0roviaWQTtfuu
	v5uhFatbr9VHA3EO4wh3PY0RQEbnSvJWUIBDJfyQnN6lTaR52EFT4h0yXDCjiWy0Iv57AILpkFV
	UxO/b8IdzdBotCElFaWGMLOvYSGgYxxuWo=
X-Google-Smtp-Source: AGHT+IENDfFn+/1B130VxmsceHEI7tVQnlMFIBJR6Lsrw5gP8PixfJq/fVaDcV8wDF7Fqq5SHznIRQ==
X-Received: by 2002:a05:620a:2956:b0:8b2:f26e:3220 with SMTP id af79cd13be357-8b33d23ac3cmr2491475885a.8.1764132948309;
        Tue, 25 Nov 2025 20:55:48 -0800 (PST)
Received: from godzilla (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b329431429sm1319801785a.14.2025.11.25.20.55.47
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Nov 2025 20:55:47 -0800 (PST)
Date: Tue, 25 Nov 2025 23:55:47 -0500 (EST)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: Re: [yocto-patches] [meta-security][scarthgap][PATCH 00/32] Roll up
 outstanding fixes
In-Reply-To: <187AC77716386BCA.66502@lists.yoctoproject.org>
Message-ID: <0b978a05-c64c-d3a1-d461-52b5444c4a58@konsulko.com>
References: <187AC77716386BCA.66502@lists.yoctoproject.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 26 Nov 2025 04:55:52 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2710

On Sun, 23 Nov 2025, Scott Murray via lists.yoctoproject.org wrote:

> This patch series attempts to get scarthgap branch back into a
> usable state.  These changes are on the scarthgap-next branch of
> meta-security, and my plan is to merge them to scarthgap branch at
> the end of day Tuesday (EST).

These have now been merged to scarthgap branch, with the exception
of patch 04, which I did confirm is now unnecessary.

Scott


> It includes:
> - All the outstanding patches to the mailing list that I could find,
>   barring one duplicate python3-fail2ban update that did not apply
>   and had a newer alternative available.
> - Changes to get the gitlab CI test pipelines to the same state as
>   master (i.e. build tests all passing).
> - Selected backports of other changes from master that seemed
>   appropriate.
>
> Things to note:
> - I chose to keep all the suricata and libhtp CVE fixes history even
>   though I've backported 7.0.12 and 0.5.52 updates on top, since I
>   figure this approach makes it easier to check if a patch submission
>   was missed.  Plus, I'm lazy, and didn't feel like squashing all that
>   away after I was done testing.
> - Going forward, I would prefer suricata and libhtp upgrades over
>   accruing a large set of CVE patches until that stops being feasible
>   for the 7.0.x and 0.5.x versions, respectively.  Those should go
>   through master branch first until it has switched to newer major
>   versions (which will be soon for suricata).
> - I believe all the backported suricata systemd support changes are
>   effectively fixes, please let me know if I'm missing something and
>   they will break your usecase.
> - The packagegroup-core-security change of PACKAGE_ARCH to MACHINE_ARCH
>   is potentially a breaking change if you're using on target package
>   updates (e.g. with dnf or apt), and for some reason using that
>   packagegroup.  My guess is that no one uses that packagegroup since
>   it's effectively special purpose for the build test image, but please
>   let me know if this will break something for you.
> - There are still some other outstanding CVEs for firejail and clamav.
>   firejail is potentially upgradeable, but clamav is problematic since
>   I believe 0.104.x was already unsupported when scarthgap shipped.
>   If you care about clamav support for scarthgap, plus provide some
>   input on if an upgrade to one of the LTS branches (1.0 or 1.4) is
>   something you would like to see / would be able to help test.
>
> Thanks,
>
> Scott
>
>
> Changes:
>
> Aidan Stewart (1):
>   smack: Switch to CVE_STATUS
>
> Armin Kuster (1):
>   harden-image-minimal: Fix usermod
>
> Chen Qi (1):
>   libgssglue: switch to use git source
>
> Clayton Casciato (6):
>   suricata: resolve TMPDIR QA issues in do_configure
>   suricata: drop pkg_postinst_ontarget systemd init
>   suricata: fix "interface" arg in systemd service
>   suricata: install classification, reference configs
>   suricata: populate SYSTEMD_SERVICE for service autostart
>   suricata: update to 7.0.12
>
> Haixiao Yan (2):
>   fail2ban: Adapt test output to Automake format for ptest compatibility
>   fail2ban: replace fail2ban-python shebang with python3
>
> Hitendra Prajapati (7):
>   suricata: fix CVE-2024-45795 & CVE-2024-45796
>   suricata: Fix CVE-2024-55605
>   clamav: fix CVE-2025-20260
>   suricata: fix multiple CVEs
>   libhtp: fix CVE-2025-53537
>   suricata: Fix multiple CVEs
>   suricata: fix CVE-2024-55627 && CVE-2024-55628
>
> Marta Rybczynska (7):
>   CI: update build for new CI
>   kas: update configuration
>   scap-security-guide: fix fetch
>   lynis: update 3.1.1 -> 3.1.4
>   chkrootkit: use debian mirror
>   checksecurity: update the debian package
>   bastille: prevent host uids on files
>
> Rasmus Villemoes (1):
>   fail2ban: update to 1.1.0+
>
> Scott Murray (4):
>   Update maintainers
>   packagegroup-core-security: add missing packages
>   meta-tpm: Small maintainers fix
>   ima-evm-utils: remove unnecessary FILESEXTRAPATHS tweak
>
> Yi Zhao (1):
>   python3-fail2ban: fix ptest failures
>
> akash hadke (1):
>   meta-security: Remove True option to getVar calls
>
>  .gitlab-ci.yml                                |   47 +-
>  README.md                                     |    4 +-
>  .../include/maintainers-meta-security.inc     |   72 +-
>  .../checksecurity/checksecurity_2.0.16.bb     |    7 +-
>  .../bastille/bastille_3.2.1.bb                |    2 +
>  ...ges-the-IPs-again.-additionally-it-g.patch |  210 +++
>  ...ao.unittest.TestRunner-for-ptest-out.patch |   43 +
>  ...case.py-set-correct-config-dir-for-t.patch |   34 +
>  ...l2ban_1.0.2.bb => python3-fail2ban_git.bb} |   40 +-
>  kas/kas-security-alt.yml                      |    2 +-
>  kas/kas-security-base.yml                     |   13 +-
>  kas/kas-security-parsec.yml                   |    2 +-
>  kas/qemuarm64-musl.yml                        |    1 +
>  kas/qemux86-musl.yml                          |    1 +
>  kas/qemux86-test.yml                          |    5 +
>  meta-hardening/README.md                      |    4 +-
>  .../images/harden-image-minimal.bb            |    4 +-
>  meta-integrity/README.md                      |    4 +-
>  meta-integrity/classes/ima-evm-rootfs.bbclass |    2 +-
>  .../ima-evm-utils/ima-evm-utils_1.5.bb        |    2 -
>  meta-parsec/README.md                         |    1 -
>  .../parsec-service/parsec-service_1.3.0.bb    |    4 +-
>  meta-tpm/README.md                            |    4 +-
>  .../distro/include/maintainers-meta-tpm.inc   |   32 +-
>  .../lynis/{lynis_3.1.1.bb => lynis_3.1.4.bb}  |    2 +-
>  .../scap-security-guide_0.1.71.bb             |    2 +-
>  .../packagegroup-core-security.bb             |    4 +
>  ...kefile-from-using-its-own-rust-steps.patch |   40 +
>  .../suricata/files/CVE-2024-45797.patch       |  148 --
>  recipes-ids/suricata/files/fixup.patch        |   32 -
>  recipes-ids/suricata/files/suricata.service   |    2 +-
>  .../{libhtp_0.5.45.bb => libhtp_0.5.52.bb}    |    6 +-
>  recipes-ids/suricata/suricata-crates.inc      | 1509 ++++++++---------
>  .../{suricata_7.0.0.bb => suricata_7.0.12.bb} |   27 +-
>  recipes-mac/smack/smack_1.3.1.bb              |    7 +-
>  recipes-scanners/clamav/clamav_0.104.4.bb     |    1 +
>  .../clamav/files/CVE-2025-20260.patch         |  366 ++++
>  recipes-scanners/rootkits/chkrootkit_0.57.bb  |    2 +-
>  recipes-security/libgssglue/libgssglue_0.8.bb |    5 +-
>  39 files changed, 1612 insertions(+), 1081 deletions(-)
>  create mode 100644 dynamic-layers/meta-python/recipes-security/fail2ban/files/0001-example.com-changes-the-IPs-again.-additionally-it-g.patch
>  create mode 100644 dynamic-layers/meta-python/recipes-security/fail2ban/files/0001-fail2ban-use-putao.unittest.TestRunner-for-ptest-out.patch
>  create mode 100644 dynamic-layers/meta-python/recipes-security/fail2ban/files/0002-clientreadertestcase.py-set-correct-config-dir-for-t.patch
>  rename dynamic-layers/meta-python/recipes-security/fail2ban/{python3-fail2ban_1.0.2.bb => python3-fail2ban_git.bb} (63%)
>  rename recipes-compliance/lynis/{lynis_3.1.1.bb => lynis_3.1.4.bb} (93%)
>  create mode 100644 recipes-ids/suricata/files/0001-Skip-pkg-Makefile-from-using-its-own-rust-steps.patch
>  delete mode 100644 recipes-ids/suricata/files/CVE-2024-45797.patch
>  delete mode 100644 recipes-ids/suricata/files/fixup.patch
>  rename recipes-ids/suricata/{libhtp_0.5.45.bb => libhtp_0.5.52.bb} (82%)
>  rename recipes-ids/suricata/{suricata_7.0.0.bb => suricata_7.0.12.bb} (82%)
>  create mode 100644 recipes-scanners/clamav/files/CVE-2025-20260.patch
>
>

