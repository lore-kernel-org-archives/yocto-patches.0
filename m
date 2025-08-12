Return-Path: <skandigraun@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCE7DCA0EC4
	for <webhook@archiver.kernel.org>; Tue, 12 Aug 2025 08:43:42 +0000 (UTC)
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
 by mx.groups.io with SMTP id smtpd.web11.69302.1754988219231768112
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 12 Aug 2025 01:43:39 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=F/7RUnuO;
 spf=pass (domain: gmail.com, ip: 209.85.208.48, mailfrom: skandigraun@gmail.com)
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-615756b1e99so7128859a12.0
        for <yocto-patches@lists.yoctoproject.org>; Tue, 12 Aug 2025 01:43:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754988217; x=1755593017; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/vW7KMUpv0iZk2kA9A0bgUDzi+DAKYwk4CAqgwvvhA8=;
        b=F/7RUnuOu6/LMKu6fpxRc1OeOqLZnfu9lUIkBZIVjJzIYrYucjj5lApYyxIoGbqVf6
         wzhzv/LViWs5ZKkp/qNkF7TNXNz7h8/WIJdntuNp1t8oe/rB5qr4/2RZ9o0pnJh9KafG
         83KKv4LTc3V8Dy5arJe4nThb3KIOA266SUrTVV1P5LEV5BlbkVdq42t50+r4L4wKvi7L
         PC94JjkfCsyGY0oNF3q8OItu6/2VmSbeIdJB+o67+yae6k07e5Qn7r+R9Mix7NEp0YC9
         Adeoz5TZ+iCAc0Ri44OXToVBEKhsAj7dYGy19q9tWqW6Ni6feod47yhTkvTuTUSPaFPQ
         wkbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754988218; x=1755593018;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/vW7KMUpv0iZk2kA9A0bgUDzi+DAKYwk4CAqgwvvhA8=;
        b=VNZGMMHyk6RUi8j4yaVfVH5AxIWVZes9yVD0gq4t67P3oVZXRVTd0dt744/PhESb6w
         TcdSAOsPdHckwX8XZUGtWO61zePuUnEIJpUOCfCSXhtMyrpZslKc2RHOsnPc09Z/E+DP
         kAJtRBey/mru8NltvuY74jnTV+STKMMV+KxJZU4bR0n7kJled2goXLrn8AbTxmaxI2MQ
         vAnBoGlUP81itv2Dt/fYsF0j51UOGuzugkprFBhYrIrSQh3i3yBFhwH3tMnNpkNGRtHT
         BTAGTlAImxE0BtLDtPJsUCKixre3tWuUoZpdQ5aYz96GAaJ8L9Nf4XR3lHnPY/OUAKb6
         1uIA==
X-Gm-Message-State: AOJu0YxokmGfRv1b9jFscrOUtpvQ7jDj2WnO13wie6/dpqzO89Cz3GiX
	FXh+Qj31BggM88oAfRVKBMqZfOBksihKp8Nt0fSySisbSDK29CcWZbEkjf1dHVZQ
X-Gm-Gg: ASbGncvl+4jOpqMiZAc7u68Zp0wDkzzeT1mxC+t8twlZJQqROZuMGtvqMBDy3+azZ9Y
	MOa553Asq/R403YnAocFNpFmSWl3ZNBd8teTY3iQOZI1XDy6A756okGy3vmA2+C1gdW9rnbMSZr
	pecx8+UAFCSVe6TwFx49wLjv26Mre6fpH8A48OqCK0u6B65nHpd31eO5EYyxv6PpNnFKBQYQ59w
	WIC63+PAakL4fkez5XeZc3h9phRYwee2DjiBGrJWiHMA/Y2PaS+xjfvNIAx8jZB+TwkQPtkq46S
	MIphanYcxlNXyOZRBRAkMRdjvKbkBq/8YPPkBP8zZzH0wKgaGtLn8BDvbRF5GW/KabezRzFRwVL
	M8MvTXXEos7iudIOy5NcLILJyFOKjDeQVWoCHuBlI
X-Google-Smtp-Source: AGHT+IETvhwz5toDzAfOENeblrbVKH4lkZpvcgsLcKgWrYMbJAsjvnmt/TmYkU1TbSLpYiQNcrvfjA==
X-Received: by 2002:a05:6402:5211:b0:617:b82d:a083 with SMTP id 4fb4d7f45d1cf-617e2e55e52mr13401726a12.17.1754988217501;
        Tue, 12 Aug 2025 01:43:37 -0700 (PDT)
Received: from [192.168.1.106] ([51.154.145.205])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-615a8ffbde5sm19628853a12.54.2025.08.12.01.43.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Aug 2025 01:43:37 -0700 (PDT)
Message-ID: <9f78b4c5-9a45-4161-890c-a37e5ace6f95@gmail.com>
Date: Tue, 12 Aug 2025 10:43:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [yocto-patches] [meta-zephyr][scarthgap][PATCH v4 12/13]
 zephyr-kernel: Add rpmsg multi services recipe
To: yocto-patches@lists.yoctoproject.org, chee.yang.lee@intel.com,
 sandeep.gundlupet-raju@amd.com
References: <20250811194646.3408854-1-sandeep.gundlupet-raju@amd.com>
 <20250811194646.3408854-13-sandeep.gundlupet-raju@amd.com>
Content-Language: en-US
From: Gyorgy Sarvari <skandigraun@gmail.com>
In-Reply-To: <20250811194646.3408854-13-sandeep.gundlupet-raju@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 12 Aug 2025 08:43:42 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1958

On 8/11/25 21:46, Sandeep Gundlupet Raju via lists.yoctoproject.org wrote:
> Add zephyr-openamp-rpmsg-mulit-services recipe to build out of tree
> openamp-system-reference example applications.
>
> Signed-off-by: Sandeep Gundlupet Raju <sandeep.gundlupet-raju@amd.com>
> ---
>  .../zephyr-openamp-rpmsg-multi-srv.bb         | 23 +++++++++++++++++++
>  1 file changed, 23 insertions(+)
>  create mode 100644 meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-openamp-rpmsg-multi-srv.bb
>
> diff --git a/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-openamp-rpmsg-multi-srv.bb b/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-openamp-rpmsg-multi-srv.bb
> new file mode 100644
> index 0000000..51152e5
> --- /dev/null
> +++ b/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-openamp-rpmsg-multi-srv.bb
> @@ -0,0 +1,23 @@
> +SUMMARY = "Open AMP rpmsg mulit services"
> +DESCRIPTION = "Open AMP rpmsg mulit services"

Typo in summary and description: mulit vs multi

> +
> +inherit zephyr-sample
> +
> +SRC_URI_ZEPHYR_OPEN_AMP_SYS_REF ?= "git:///github.com/OpenAMP/openamp-system-reference;protocol=https"

Typo in src_uri: there is an extra slash after the "git://" protocol.

> +
> +BRANCH ?= "v2024.05"
> +BRANCHARG = "${@['nobranch=1', 'branch=${BRANCH}'][d.getVar('BRANCH', True) != '']}"
> +
> +SRC_URI:append = " \
> +    ${SRC_URI_ZEPHYR_OPEN_AMP_SYS_REF};name=open-amp-sys-ref;${BRANCHARG};destsuffix=git/open-amp-sys-ref \
> +    "
> +
> +SRCREV_open-amp-sys-ref = "d78315763fbacba8a74552d0ad570bd01c42ccf9"
> +
> +ZEPHYR_SRC_DIR = "${ZEPHYR_BASE}/../open-amp-sys-ref/examples/zephyr/rpmsg_multi_services"
> +
> +ZEPHYR_MAKE_OUTPUT = "rpmsg_multi_services.elf"
> +
> +EXTRA_OECMAKE += " \
> +    -DCONF_FILE="prj.conf" \
> +    "


