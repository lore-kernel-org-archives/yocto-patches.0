Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC546CD13DE
	for <webhook@archiver.kernel.org>; Thu, 30 Apr 2026 22:59:25 +0000 (UTC)
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.3105.1777589963074446462
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 30 Apr 2026 15:59:23 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=W3XCuUh2;
 spf=pass (domain: konsulko.com, ip: 209.85.160.178, mailfrom: scott.murray@konsulko.com)
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-50d880e6fbbso23217451cf.0
        for <yocto-patches@lists.yoctoproject.org>; Thu, 30 Apr 2026 15:59:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1777589962; x=1778194762; darn=lists.yoctoproject.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=+zKmannSIbW1Lw/IHhx4QfV2/22PDxqD5VHHZjcNSMc=;
        b=W3XCuUh2xw+ovqK5v9z+T2ebB3blrq6BBY440vtFBrK59eY1LPvvPKSFh0S8nrB89d
         q4Xfnz25KpkdnPbdd8VYmMud7EAk5cmWsrUVVxWDn5DPv//MZyaXZ+E8f4nKgfhGq2Zy
         +m7S1DAf5PaZealdc2EChd8FjBLzA5z/fDh5o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777589962; x=1778194762;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+zKmannSIbW1Lw/IHhx4QfV2/22PDxqD5VHHZjcNSMc=;
        b=SIyprJ7cBipC8+Syo3EKAvyNOglltBsZy8lcFHxDEAzg7EYmaG9z0/x6S/1TF7i+Dz
         nqcd5J2ox9F06fkXX1yTqc7sdfCva7DVW7fEOZ4yhDRRFPg4DEuaTHGYHnRf/x9b7jjt
         HTNLAdsLFKsAT29Nltu2EfKgLu8ULcQlMizmQvbTnSOY9aJeW6xmps/+Im95P8/6tvLH
         LlUHSt/TWJ3E/7QFxUCNzu2IVQLA4HVKUKuoyFJMzIsGe3hm7x5fCJ3ZTfH6vDJCwGUU
         TCYz/PyTyQunxKxZ5u5ievs/SweIAzhOEl98IXq8TbO9L8KcbytdjQ2NbULC+nG8+Lyc
         71jw==
X-Gm-Message-State: AOJu0YzncX1EQDAlkptlPfl2BbgCPX5UIhCsStxKGnSZmia8+QSISphu
	1bkiDkkqp3dm6TjxIKqh0N5pUxXU6ORtTVAB634UdjIkfGUAOCwnS0Xx8jVHM2xZP2rwnd2D6Or
	QW5eM
X-Gm-Gg: AeBDieuAUTD23WyggwpA1dbpw3hgNlE26BTo8b55GHMnTA97iIYgVFbQyb+LjUqeovv
	u75ls0Ca4MH7SO/TBJNeHZ3Y6Y+REIYGPVr547rzoC63ODJ06ii5/cOWMrEHvoZh/UACfHibGjT
	dBJ92H1Xps4PwIuLmN2QOYZV10ih9DKv0UJ2t0W3P1ejOiWPEyvp2bULWhSYGeeL6CuEUSDbxHa
	obSsWBraIcQ0tdOWW9R+zVEtsnAjXZw3YTlMbRB3jS9qSOoya6CaU7IECI4ld9jSO0zaHuttmK+
	bOpzbLwvBeJNnujXiaaPu+ak+xJvAT5cbYqslFOtGPdI4NUqz8+WAMfqtUKoZMkcpr7iHIP8tKy
	2f/oYqN7Y6pNUZhgZxRvdcL+/a2BLb9goAcCe78JpmhMAkL9QsBCWDSO3JB7Qlx80+DrZrAM/k9
	i+QzK7rAbnsI3ieGrZQ8NyLPPfQ4Zmr9hgJn93pwseRh8jXraOi2+vRAJiNjNjQ8COcpvBgORUn
	YJJOBDW5VB/vgVDGSy3/sdT3YzXZV03P8eygI3+rF2MOwOaI4gbzH6TjA==
X-Received: by 2002:a05:622a:587:b0:509:11bd:9d3 with SMTP id d75a77b69052e-5102d09918amr58979161cf.1.1777589961694;
        Thu, 30 Apr 2026 15:59:21 -0700 (PDT)
Received: from godzilla (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5103e5437f1sm3625831cf.15.2026.04.30.15.59.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2026 15:59:21 -0700 (PDT)
Date: Thu, 30 Apr 2026 18:59:20 -0400 (EDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
cc: Marta Rybczynska <rybczynska@gmail.com>
Subject: Re: [yocto-patches] [meta-security][PATCH 00/13] Assorted updates
 04/29 and wrynose branch plan
In-Reply-To: <18AADE1B4D01262A.2390993@lists.yoctoproject.org>
Message-ID: <4f2666da-cdf6-a5a2-bd2c-f0e796314710@konsulko.com>
References: <18AADE1B4D01262A.2390993@lists.yoctoproject.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 30 Apr 2026 22:59:25 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3894

On Wed, 29 Apr 2026, Scott Murray via lists.yoctoproject.org wrote:

> This patch series rolls up the contributed patches (barring some from the
> past few days), plus several recipe upgrades/fixes from myself with the
> aim of getting known breakage fixed before cutting the wrynose branch
> (see below).  These changes are queued on the master-next branch if you
> would like to check them out to test yourself.  I intend to merge these
> to master branch tomorrow evening (Eastern Time, April 30) unless there
> are objections.

These have now been pushed to master branch.

> With respect to the wrynose branch, the plan is to push it by the end of
> the week, or on the weekend if vetting CI takes a bit longer than expected.
> The one remaining known breakage that I am aware of is parsec-service
> not building; Anton has triaged it, but so far we have not come up with
> a fix.  Once we have one, it will be backported ASAP.

I have also pushed the wrynose branch since the CI testing matched the
master results.

Scott


> Changes:
>
> Clayton Casciato (1):
>   suricata: update 7.0.13 -> 8.0.4
>
> Marta Rybczynska (1):
>   README: update CI links
>
> Scott Murray (10):
>   crowdsec: Upgrade to v1.7.7
>   aircrack-ng: Upgrade to 1.7
>   opendnssec: Upgrade to 2.1.14
>   libmspack: Remove
>   clamav: Upgrade to 1.4.4
>   aide: Upgrade to 0.19.3
>   libmhash: Remove
>   ncrack: Update
>   packagegroup-core-security: Add missing packages
>   packagegroup-core-security: remove python3-privacyidea
>
> Wenlin Kang (1):
>   krill: fix missing dollar sign in FILES
>
>  README.md                                     |    6 +-
>  .../include/maintainers-meta-security.inc     |    2 -
>  .../packagegroup-core-security.bbappend       |    1 -
>  .../packagegroup-core-security.bb             |    5 +-
>  .../aide/aide/0001-Fixes-build-issues.patch   |   37 +
>  recipes-ids/aide/aide/m4_allow.patch          |   40 -
>  .../aide/{aide_0.18.8.bb => aide_0.19.3.bb}   |   15 +-
>  recipes-ids/crowdsec/crowdsec-go-mods.inc     |  523 +++
>  recipes-ids/crowdsec/crowdsec-licenses.inc    |  239 ++
>  recipes-ids/crowdsec/crowdsec_1.1.1.bb        |   40 -
>  recipes-ids/crowdsec/crowdsec_1.7.7.bb        |   29 +
>  ...kefile-from-using-its-own-rust-steps.patch |   36 +-
>  recipes-ids/suricata/libhtp_0.5.52.bb         |   23 -
>  recipes-ids/suricata/suricata-crates.inc      | 3282 +++++++++++++----
>  .../{suricata_7.0.13.bb => suricata_8.0.4.bb} |   31 +-
>  recipes-scanners/clamav/clamav-crates.inc     |  180 +-
>  .../{clamav_1.4.3.bb => clamav_1.4.4.bb}      |    6 +-
>  ...001-Remove-build-directory-reference.patch |   79 +
>  .../aircrack-ng/aircrack-ng_1.6.bb            |   36 -
>  .../aircrack-ng/aircrack-ng_1.7.bb            |   54 +
>  recipes-security/krill/krill_0.12.3.bb        |    2 +-
>  recipes-security/libmhash/files/Makefile.test |   13 -
>  recipes-security/libmhash/files/mhash.c       |   32 -
>  recipes-security/libmhash/files/run-ptest     |   12 -
>  recipes-security/libmhash/libmhash_0.9.9.9.bb |   47 -
>  recipes-security/libmspack/libmspack_1.11.bb  |   16 -
>  recipes-security/ncrack/ncrack_0.7.bb         |    8 +-
>  ...1-Fix-implicit-function-declarations.patch |   51 +
>  .../files/0001-include-utilities.h.patch      |   33 +
>  ...rder-header-files-and-include-time.h.patch |   39 +
>  ...ndnssec_2.1.10.bb => opendnssec_2.1.14.bb} |   15 +-
>  31 files changed, 3941 insertions(+), 991 deletions(-)
>  create mode 100644 recipes-ids/aide/aide/0001-Fixes-build-issues.patch
>  delete mode 100644 recipes-ids/aide/aide/m4_allow.patch
>  rename recipes-ids/aide/{aide_0.18.8.bb => aide_0.19.3.bb} (85%)
>  create mode 100644 recipes-ids/crowdsec/crowdsec-go-mods.inc
>  create mode 100644 recipes-ids/crowdsec/crowdsec-licenses.inc
>  delete mode 100644 recipes-ids/crowdsec/crowdsec_1.1.1.bb
>  create mode 100644 recipes-ids/crowdsec/crowdsec_1.7.7.bb
>  delete mode 100644 recipes-ids/suricata/libhtp_0.5.52.bb
>  rename recipes-ids/suricata/{suricata_7.0.13.bb => suricata_8.0.4.bb} (86%)
>  rename recipes-scanners/clamav/{clamav_1.4.3.bb => clamav_1.4.4.bb} (98%)
>  create mode 100644 recipes-security/aircrack-ng/aircrack-ng/0001-Remove-build-directory-reference.patch
>  delete mode 100644 recipes-security/aircrack-ng/aircrack-ng_1.6.bb
>  create mode 100644 recipes-security/aircrack-ng/aircrack-ng_1.7.bb
>  delete mode 100644 recipes-security/libmhash/files/Makefile.test
>  delete mode 100644 recipes-security/libmhash/files/mhash.c
>  delete mode 100644 recipes-security/libmhash/files/run-ptest
>  delete mode 100644 recipes-security/libmhash/libmhash_0.9.9.9.bb
>  delete mode 100644 recipes-security/libmspack/libmspack_1.11.bb
>  create mode 100644 recipes-security/opendnssec/files/0001-Fix-implicit-function-declarations.patch
>  create mode 100644 recipes-security/opendnssec/files/0001-include-utilities.h.patch
>  create mode 100644 recipes-security/opendnssec/files/0002-reorder-header-files-and-include-time.h.patch
>  rename recipes-security/opendnssec/{opendnssec_2.1.10.bb => opendnssec_2.1.14.bb} (70%)
>
>

