Return-Path: <joe@deserted.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0891C19F32
	for <webhook@archiver.kernel.org>; Fri,  7 Mar 2025 19:54:41 +0000 (UTC)
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
 by mx.groups.io with SMTP id smtpd.web11.20255.1741377275503559829
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 07 Mar 2025 11:54:35 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@deserted-net.20230601.gappssmtp.com header.s=20230601 header.b=WJPivRPi;
 spf=none, err=permanent DNS error (domain: deserted.net, ip: 209.85.222.169, mailfrom: joe@deserted.net)
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7c3b63dfebfso254826185a.3
        for <yocto-patches@lists.yoctoproject.org>; Fri, 07 Mar 2025 11:54:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=deserted-net.20230601.gappssmtp.com; s=20230601; t=1741377274; x=1741982074; darn=lists.yoctoproject.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LA0vHtliVRiUjpEBaEMOYwex3sa+GEI/PIuGIeCzufs=;
        b=WJPivRPiyBdg/DW0HjAj3c7SEl7cw4XzX/5njaRYLyrbPx9KtGlY6Tit6ycdFOmHoo
         oTuskAwCmlZC09iKtqxBPizpEqtRJlL3aTUpzgIOO6mT/R7n1yUH42OJYvrgFtI/Mbfg
         AaNUSV/5sVX+/f+qB7YToyUYh9NHf6F91x2KV5q7HGwEKdmfnR7ZZ7B35g4o3AQ9Y4V5
         CQVDxXnB/voX4OGJyq5FcokD/isZjvqlbGyDwdyKb1HODbAq4V2kzKfom7xIyeGqZx5Z
         35KQJORgqyopJiPQvM31C+sqjtXvyclCOe/AxYm8uq6FK8mTNegl2UZ4KfQMNlIuwCH1
         7Qiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741377274; x=1741982074;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LA0vHtliVRiUjpEBaEMOYwex3sa+GEI/PIuGIeCzufs=;
        b=w/nu+xYYPbM2DxogZH8KLb4JENsIBi/+EICHJ6X5PfcOjM2S51xfSicNJlXnUIi2BM
         mAt1GP3YnxJdj/h9wI903vN5u4I9C6ovUE2ifOgSPNfu5BLzcr4OiywYvrISvQRfwEuB
         gNCJ2vq2YrZhe7Abwk+OQc9aV0hSE9mjfnwQTtnt7d2PmwPIJ+UKD7vdUDyCDZ92QwDk
         XCDjy0VaksnLTxK9m9lFr0A14/XNyQSrISzGlaaIJZKuibx/ZhO0pXw+K9vpIqeF4ubE
         +mgezjEU2VwfB/47f75AJMJe9Lu64PxiKK7avvDNTjr8L/cmQsbC+uO9WwPYHjseLhBY
         N3/g==
X-Gm-Message-State: AOJu0YxEtH6mT4n8/LHRa+nn9Nw6y5XSD2gLxMYrxohpnBfiBlOgOZNg
	IjqiU2H7fN9xcIxgPogvEi2hgSZqi1rG3tFWiIpYBnL7cYOPzEohRgvlw5IHMD41Jh03gy8Utgs
	=
X-Gm-Gg: ASbGnctSR+zq2qh5tWSqFiAVm/qJrzvb2vhFomtDG43AWE7kPRUx9v36t3iXS1jN1GM
	NJd+zqhU2RuLDVO9HBAwln2RWQm7+/MlLc9XCUOcwdEVvmxY6uM9fBAWtiDFLaSXHxn0GI2zA/3
	6IZvylZxSuQpuv0VlbzqRhbzteysLbPL+7idm/CrFXU9uU9zOI7fgN4ClKTGpm8gwbffTvbv0Mz
	hWCYYWhhaB/cnvIeMppr4XwWH2+zBdodaKy9KWpF5lzWVYDKNDdlg/aOMZW6ym7hvsGFKR4TTrV
	2esupxDW6c1cUSU/JOwveo+Zuy5/s0cZi1c5id2rNnv0u3jSZ9XxHhDPlXWj7z6EhZ+XorwJ/v2
	btJljQOje51ln35KUVq1yhi1N6PtnqMjMIUzHcMkNjkGAlg==
X-Google-Smtp-Source: AGHT+IH0Nb2Nrn34kdFsyRNzefAnOwWJpCXkbOmltbtRx/b4uCMJOmIYRvthSYD7oK8adXzVy2Tkxw==
X-Received: by 2002:a05:620a:601c:b0:7c3:c01e:ad0a with SMTP id af79cd13be357-7c4e61994efmr819242885a.49.1741377274119;
        Fri, 07 Mar 2025 11:54:34 -0800 (PST)
Received: from nightwinge.deserted.net (lnsm4-toronto63-142-116-171-27.internet.virginmobile.ca. [142.116.171.27])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c3e5339df1sm282951385a.4.2025.03.07.11.54.33
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Mar 2025 11:54:33 -0800 (PST)
Date: Fri, 7 Mar 2025 14:54:33 -0500
From: Joe MacDonald <joe@deserted.net>
To: yocto-patches@lists.yoctoproject.org
Subject: Re: [yocto-patches] [meta-selinux] [scarthgap] [PATCH] selinux: Mark
 CVE-2020-10751 as Patched
Message-ID: <fxbaxyqnwdlmn3yxn63kejmnduxzl4da7nepdzlpti7dmnrknt@dz36stjy4r7v>
References: <20250120052019.2945142-1-madmarri@cisco.com>
 <SJ0PR11MB5677B53A0FB2297F53F094E5CDEE2@SJ0PR11MB5677.namprd11.prod.outlook.com>
 <SJ0PR11MB567701EFE9AA4C2E937906C4CDCC2@SJ0PR11MB5677.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <SJ0PR11MB567701EFE9AA4C2E937906C4CDCC2@SJ0PR11MB5677.namprd11.prod.outlook.com>
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 07 Mar 2025 19:54:41 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1165

Hi Madhu,

Sorry about the delay, it should be merged to the scarthgap branch now,
please have a look and let me know if there's any trouble.

Thanks.
-Joe.

[Re: [yocto-patches] [meta-selinux] [scarthgap] [PATCH] selinux: Mark CVE-2020-10751 as Patched] On 25.02.28 (Fri 04:05) Madhu Marri via lists.yoctoproject.org wrote:

> Hi Team,
> 
> Any updates on the patch review. 
> 
> Thanks
> Madhu
> 
> ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
> From: Madhu Marri -X (madmarri - E INFOCHIPS PRIVATE LIMITED at Cisco)
> <madmarri@cisco.com>
> Sent: Monday, February 3, 2025 9:15 AM
> To: yocto-patches@lists.yoctoproject.org <yocto-patches@lists.yoctoproject.org>
> Cc: xe-linux-external(mailer list) <xe-linux-external@cisco.com>
> Subject: Re: [meta-selinux] [scarthgap] [PATCH] selinux: Mark CVE-2020-10751 as
> Patched
>  
> Hi Team,
> 
> Could you please update on this patchset review. 
> 
> Thanks
> Madhu
> 
> ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
> From: Madhu Marri <madmarri@cisco.com>
> Sent: Monday, January 20, 2025 10:50 AM
> To: yocto-patches@lists.yoctoproject.org <yocto-patches@lists.yoctoproject.org>
> Cc: xe-linux-external(mailer list) <xe-linux-external@cisco.com>; Madhu Marri
> -X (madmarri - E INFOCHIPS PRIVATE LIMITED at Cisco) <madmarri@cisco.com>
> Subject: [meta-selinux] [scarthgap] [PATCH] selinux: Mark CVE-2020-10751 as
> Patched
>  
> Bug Details: https://nvd.nist.gov/vuln/detail/CVE-2020-10751
> Type: Security Advisory
> CVE: CVE-2020-10751
> Score: 6.1
> Patch: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/
> commit/?id=fb73974172ff
> 
> Analysis:
> - This is a selinux cve which is addressed in kernel.
> - The fix is available at [1].
> - Hence, marking the CVE as patched.
> 
> Reference:
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?
> id=fb73974172ff
> 
> Signed-off-by: Madhu Marri <madmarri@cisco.com>
> ---
>  recipes-security/selinux/selinux_common.inc | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/recipes-security/selinux/selinux_common.inc b/recipes-security/
> selinux/selinux_common.inc
> index cecb0b5..d8c91ac 100644
> --- a/recipes-security/selinux/selinux_common.inc
> +++ b/recipes-security/selinux/selinux_common.inc
> @@ -19,3 +19,5 @@ do_install() {
>  }
>  
>  CVE_PRODUCT ?= "kernel:selinux"
> +
> +CVE_STATUS[CVE-2020-10751] = "fixed-version: Fix is present in the current
> kernel version."
> --
> 2.44.1
> 
> _._,_._,_
> ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
> Links:
> 
> You receive all messages sent to this group.
> 
> View/Reply Online (#1136) | Reply to Group | Reply to Sender | Mute This Topic
> | New Topic
> Your Subscription | Contact Group Owner | Unsubscribe [joe@deserted.net]
> _._,_._,_

-- 
-Joe MacDonald.
:wq

