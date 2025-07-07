Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22D8CC8303C
	for <webhook@archiver.kernel.org>; Mon,  7 Jul 2025 18:41:04 +0000 (UTC)
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
 by mx.groups.io with SMTP id smtpd.web11.765.1751913659704650237
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 07 Jul 2025 11:40:59 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=qsmx6Tv2;
 spf=pass (domain: konsulko.com, ip: 209.85.222.169, mailfrom: scott.murray@konsulko.com)
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7d5d1feca18so420799185a.2
        for <yocto-patches@lists.yoctoproject.org>; Mon, 07 Jul 2025 11:40:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1751913658; x=1752518458; darn=lists.yoctoproject.org;
        h=mime-version:references:message-id:in-reply-to:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KGBi8P/L1xQ96LZEqJDZfEj5K3xQW2fUU8KKJYg/s7c=;
        b=qsmx6Tv2OhxEVjRT20oBsLa9FIHPxxFibeBdLLc3E1sugHT1UgC79ob+8fMlE/ItvB
         +dYYRD/Bpl8t3SmAPz6qpbEH2gavo/gV0HlSpUsKNw5cFVtb2uT45Fv28xkpjAYVTUNW
         wMRExT9+ATO6T4DZvWKV83I96yiNLIrRPwlyU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751913658; x=1752518458;
        h=mime-version:references:message-id:in-reply-to:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KGBi8P/L1xQ96LZEqJDZfEj5K3xQW2fUU8KKJYg/s7c=;
        b=c8HXIESjQroEefMIVWtBhupO7acb4V9o4xlyk7+jIn6dEvwODhS5HefOsv7zayCqfX
         1XoH9WKtodXLl9fSaca6O+tVTD0SVDNXFQNOMJjJ3u0F/lZ/NZfaP96jDhA1sno8QzS2
         73k+5cBFgxsnv5pj7SYpLQemyFhuoaQW3MydiVJEcWlVKF7gajuiJ1Esqv4hzSWB3aE9
         2VSC8RUG05HMfz6+J/ZXFbEwZvJpWULcX5MqECUAgLiXYxUN5189cKlKqxzUgtF4i2zC
         6O9r1udalWiuwDeScdY70X5uZIVzJAoNJoAFFH1ZeVdHBFAI47xW/LJAYMAY1/jZnWo7
         7YVQ==
X-Gm-Message-State: AOJu0YyqYN3t7ydnBijXBjlqUFWQsoUOFzzstRo6CLUwoOOt4hoxPN+q
	4v/nirYmUAUJPY4U3wjYoumHmil3j31fhi56nacaDrcKH360Qsmqtaj4cuMAOzuEhpf/TFwQkJh
	twQ0c
X-Gm-Gg: ASbGnctno7SiGhQ/CBtu2HdcTSgahiJQbozkC6864K6LfvO7GHAeHw+zsIX4WpqbIXG
	uJvku/mJyL6wIdixbErAgTPtpVOiheF+B9W04HIii+IlqZ1nmJoNQcgJx+sbkPTZVdJWKefvp9D
	VUbRBkZe6OjTRrZZJXP8kIdN/L4zWn+79tHHZ3fs0H3wlEKqLTg0vmPc+rPeZoGLIiuDze4PUJ+
	taB/JRnovakKFA4/xOn+xh+uE/+FcLrQYWYxyoPmyb72KiuWUoA0fj4PEpGUWKdgP8wyWmGbAAx
	J3CLLddihz6RulYEeam8q3YPl6oicYduDUpdh5RV8uh0RA7MmKqnY0vDXMr+kyOiC8xMUvJ1pWV
	N5zUDV/Ghv8Holx/hMLPe
X-Google-Smtp-Source: AGHT+IEa0bBXsNlK+EVW8lkpvvz/Scvot9zJc2u5zFsyanq0+uNLxPniW6kZWOr+7Wty0acfIc/g8A==
X-Received: by 2002:a05:620a:7085:b0:7d4:4b9b:3eed with SMTP id af79cd13be357-7d5df1130c8mr1931774285a.25.1751913658116;
        Mon, 07 Jul 2025 11:40:58 -0700 (PDT)
Received: from godzilla (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7d5dbeaed91sm645041185a.100.2025.07.07.11.40.57
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jul 2025 11:40:57 -0700 (PDT)
Date: Mon, 7 Jul 2025 14:40:56 -0400 (EDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: Re: [yocto-patches] [meta-security][PATCH 00/12] Initial fixes for
 master branch
In-Reply-To: <184F1B9597C17008.7007@lists.yoctoproject.org>
Message-ID: <093773af-5310-49f3-a535-f7515f1562a0@konsulko.com>
References: <184F1B9597C17008.7007@lists.yoctoproject.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 07 Jul 2025 18:41:04 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1778

On Fri, 4 Jul 2025, Scott Murray via lists.yoctoproject.org wrote:

> Thank you for your patience, this patch series is a start on getting
> master branch maintenance back in order, and allowing Marta and myself
> to try getting through some resource estimating for the new CI setup.
> The focus has been on patches that allow getting through clean builds
> of the majority of the build tests in the CI pipeline, which I have done
> manually for qemux86-64.  We will shake out any other issues as the CI
> setup is tested (or reported via the list).
>
> Note that I did pick a few patches from the backlog on the mailing list,
> but generally not things that were not build warning or failure fixes.
> I did the S/UNPACKDIR changes myself, as I had started on them before
> any of patches were posted to the list.  Additionally, there are 3
> fixes for gcc 15 issues (the libhoth patches will be sent upstream
> in the next day or two).
>
> I would ask that you give us a few days before sending (or resending)
> patches with any expectation of immediate turnaround.  There is still
> quite a bit of work to recreate a working CI setup, as well as ensuring
> walnascar and scarthgap branches are in a testable state.  This series
> has been pushed to master-next, and while I'm aware of the US long
> weekend holiday, the goal is to merge these changes to master by Monday
> afternoon at the latest, as I have some conference travel next week, and
> we do need to unblock folks testing against master branch.

I have gone ahead and merged these changes into master branch, please
let us know if you still have any parse/build issues.  As I mentioned
above, I am travelling this week, so turnaround on patches sent to the
list will be affected by that and our focus being on getting CI working.

Thanks,

Scott

> Changes:
>
> Anton Antonov (1):
>   parsec-service: update PACKAGECONFIG options as lists of cargo build
>     features
>
> Clayton Casciato (1):
>   smack: Use new CVE_STATUS variable
>
> J. S. (1):
>   Fix warning : lack of whitespace around assignment
>
> Marta Rybczynska (4):
>   scap-security-guide: fix fetch
>   chkrootkit: use Debian mirror
>   CI: update build for new CI
>   .gitlab-ci.yml: add logging of jobs to files
>
> Scott Murray (5):
>   layer.conf: Update to whinlatter (5.3) release
>   Adapt to S/UNPACKDIR changes
>   sshguard: Update to 2.5.1
>   libhoth: update to latest
>   chkrootkit: fix building with gcc 15
>
>  .gitlab-ci.yml                                |  45 +++---
>  conf/layer.conf                               |   2 +-
>  .../checksecurity/checksecurity_2.0.16.bb     |   5 +-
>  .../bastille/bastille_3.2.1.bb                |   2 +-
>  .../recipes-security/nikto/nikto_2.1.6.bb     |   2 +-
>  .../python/python3-json2html_1.3.0.bb         |   2 +-
>  .../python/python3-xmldiff_2.7.0.bb           |   2 +-
>  .../fail2ban/python3-fail2ban_git.bb          |   2 -
>  meta-hardening/conf/layer.conf                |   2 +-
>  meta-integrity/conf/layer.conf                |   2 +-
>  meta-parsec/README.md                         |   4 +-
>  meta-parsec/conf/layer.conf                   |   2 +-
>  .../parsec-service/parsec-service_1.4.1.bb    |  15 +-
>  meta-tpm/conf/layer.conf                      |   2 +-
>  meta-tpm/recipes-tpm/libtpm/libtpms_0.10.0.bb |   1 -
>  meta-tpm/recipes-tpm/swtpm/swtpm_0.10.0.bb    |   2 -
>  .../0001-Fix-building-with-gcc-15.patch       | 151 ++++++++++++++++++
>  ...02-Fix-building-without-dbus-backend.patch |  36 +++++
>  meta-tpm/recipes-tpm1/hoth/libhoth_git.bb     |  13 +-
>  .../openssl-tpm-engine_0.5.0.bb               |   2 -
>  .../recipes-tpm1/pcr-extend/pcr-extend_git.bb |   2 -
>  .../tpm-quote-tools/tpm-quote-tools_1.0.4.bb  |   1 -
>  .../tpm-tools/tpm-tools_1.3.9.2.bb            |   2 -
>  .../recipes-tpm1/trousers/trousers_git.bb     |   2 -
>  .../ibmswtpm2/ibmswtpm2_183-2024-03-27.bb     |   2 +-
>  .../ibmtpm2tss/ibmtpm2tss_2.2.0.bb            |   2 -
>  .../tpm2-tcti-uefi/tpm2-tcti-uefi_0.9.9.bb    |   2 -
>  .../recipes-tpm2/tpm2-totp/tpm2-totp_0.3.0.bb |   2 -
>  recipes-compliance/openscap/openscap_1.4.1.bb |   2 -
>  .../scap-security-guide_0.1.76.bb             |   9 +-
>  recipes-ids/aide/aide_0.18.8.bb               |   2 +-
>  recipes-ids/crowdsec/crowdsec_1.1.1.bb        |   2 -
>  recipes-ids/ossec/ossec-hids_3.7.0.bb         |   5 +-
>  recipes-ids/suricata/libhtp_0.5.50.bb         |   4 -
>  recipes-ids/tripwire/tripwire_2.4.3.7.bb      |   4 +-
>  recipes-kernel/lkrg/lkrg-module_0.9.7.bb      |   4 +-
>  recipes-mac/AppArmor/apparmor_4.0.3.bb        |   1 -
>  recipes-mac/ccs-tools/ccs-tools_1.8.9.bb      |   4 +-
>  recipes-mac/smack/mmap-smack-test_1.0.bb      |   3 +-
>  recipes-mac/smack/smack-test_1.0.bb           |   3 +-
>  recipes-mac/smack/smack_1.3.1.bb              |  10 +-
>  recipes-mac/smack/tcp-smack-test_1.0.bb       |   3 +-
>  recipes-mac/smack/udp-smack-test_1.0.bb       |   3 +-
>  recipes-perl/perl/libwhisker2-perl_2.5.bb     |   2 +-
>  recipes-scanners/checksec/checksec_2.6.0.bb   |   4 +-
>  recipes-scanners/clamav/clamav_0.104.4.bb     |   1 -
>  recipes-scanners/rootkits/chkrootkit_0.58b.bb |   7 +-
>  .../files/0001-Fix-building-with-gcc-15.patch |  39 +++++
>  recipes-security/Firejail/firejail_0.9.72.bb  |   2 -
>  recipes-security/chipsec/chipsec_1.9.1.bb     |   2 -
>  .../cryptmount/cryptmount_6.2.0.bb            |   2 +-
>  recipes-security/fscrypt/fscrypt_1.1.0.bb     |   2 -
>  .../fscryptctl/fscryptctl_1.1.0.bb            |   2 -
>  recipes-security/glome/glome_git.bb           |   1 -
>  .../google-authenticator-libpam_1.09.bb       |   2 -
>  recipes-security/isic/isic_0.07.bb            |   2 +-
>  recipes-security/krill/krill_0.12.3.bb        |   1 -
>  recipes-security/libest/libest_3.2.0.bb       |   2 -
>  recipes-security/libgssglue/libgssglue_0.9.bb |   2 -
>  recipes-security/libmspack/libmspack_1.11.bb  |   2 +-
>  recipes-security/ncrack/ncrack_0.7.bb         |   2 -
>  .../redhat-security/redhat-security_1.0.bb    |   3 +-
>  recipes-security/sshguard/sshguard_2.4.3.bb   |  11 --
>  recipes-security/sshguard/sshguard_2.5.1.bb   |  11 ++
>  64 files changed, 319 insertions(+), 151 deletions(-)
>  create mode 100644 meta-tpm/recipes-tpm1/hoth/libhoth/0001-Fix-building-with-gcc-15.patch
>  create mode 100644 meta-tpm/recipes-tpm1/hoth/libhoth/0002-Fix-building-without-dbus-backend.patch
>  create mode 100644 recipes-scanners/rootkits/files/0001-Fix-building-with-gcc-15.patch
>  delete mode 100644 recipes-security/sshguard/sshguard_2.4.3.bb
>  create mode 100644 recipes-security/sshguard/sshguard_2.5.1.bb
>
>

