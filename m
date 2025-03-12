Return-Path: <mikko.rapeli@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94CF5C28B28
	for <webhook@archiver.kernel.org>; Wed, 12 Mar 2025 10:38:28 +0000 (UTC)
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
 by mx.groups.io with SMTP id smtpd.web10.33696.1741775898983289841
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 12 Mar 2025 03:38:19 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=y6ZInLwk;
 spf=pass (domain: linaro.org, ip: 209.85.208.171, mailfrom: mikko.rapeli@linaro.org)
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-30bee278c2aso7978931fa.0
        for <yocto-patches@lists.yoctoproject.org>; Wed, 12 Mar 2025 03:38:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741775897; x=1742380697; darn=lists.yoctoproject.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=N9qy7JZr+raFcV1UCcLpMFsaUWjLFqLcsgp1EGSBAyU=;
        b=y6ZInLwkiS3ifpDNGPgA+aTpNVVEJ993u3eqAYAlhueG2HvxZh/hZRK3G1tFv0vM+G
         CM+1W0ICkE3QscdFeHMDqvsT3iQHqIn/b4grxlrPpUoOxc3NZI2hw/MlRrNcG2nrlT0j
         C1j9BwQqY2eSX8jLRz8j1RQ3iIPy9WIlnZzCIbWjwpZBaf4oGHuTqKkg5i86if4gRNMt
         865HYRf0BuxnRzJdwwYbGvqpY/m3b1747BaK3KuWRq2Fra8PMzXCqWGbvfuQvyZ3IapZ
         cpJLEtjNBZVsRY5FjW3r8fRiUh64Sw28SCk8n6M9apdESCEfGkV3bM41a9WylYvpd/Wx
         /seQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741775897; x=1742380697;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N9qy7JZr+raFcV1UCcLpMFsaUWjLFqLcsgp1EGSBAyU=;
        b=Nxdwb43c3WiUZMwl9kbfnNKt88NNcka/CtxceF2Xg/zJIfKx2okx7+Xb/ROX2/yP69
         NCk+IabcRFhQLplzz+rOvpG9IWGaIS2tunWjQui5ZFaQb8/xRnMCNsX3Fkq9dtOFEBF1
         jm/zdSER2tycBMrOXUPy2zj6a0DUY2XuJftGTa0fdz6645WUtZdvDmYgK8ykr05KIsiF
         M0sPx+r5Qz+GLLHhEYXWhcS7nhwO+PV317z9no37pB0Lk2ujvGaDCnkXQHkpZtwxpQW8
         Nj0JDvvXZlrnszi4dqcjD7+zg86ZIVCIU2LOFY8Iu3XRaAS1RxsRd5ImK+kyqyeZ4O8q
         7wyg==
X-Gm-Message-State: AOJu0YzFOZNK5xxyu0ZPT8rOp2S9GuOEBcMwsfg1GrhJHWGtRcApvHmp
	Rp2eDwnaVSrkssKYObPaTM6SfYnXjNrjrgLvwV0Oo8elKYUew+aX7dJgenHktzAtU46/YaPbLVA
	1kBE=
X-Gm-Gg: ASbGnctA5Wl03SlNUHEIkY7rWVXuA3h/IURFGqWFqMiExIgKDBveC1VK/8B2gsA6joM
	Cu1NLLWpN3ALDqPkwX7xNjjTRIppDOEljZQYlkI2VEGLuRohgf5d64/lZ5AtYm6miWmnM1rxZww
	D1vkWklcrTBoZ8bKsPl41MisZHNpVK1bEnV1oqiqN0jMi75bg/qY3D+IsNlRVyOjvRU2ZfOED1j
	9537JpqpWhQFTM98fCKbOSC9XRm9CBUKf4gTbhPbh/jAjm3b7llmZ8FXDOPD7Cz+pr9qW9g9W5l
	lT2KELSEB2iYM/gcPiXo2/mtBKb1yU70/LZAo1wkeuRifLiax47vS2BDS2CD6iue/Tk2adFOmYn
	oY0cK
X-Google-Smtp-Source: AGHT+IEiQyUXBo48VYILyAVEXfZ58z+5cAxe9UHijVxj9RNlNw8js+vvutDnff8RWp8VFi3UQq69aw==
X-Received: by 2002:a05:6512:68d:b0:549:8d2f:86dd with SMTP id 2adb3069b0e04-549abd55c4bmr2611789e87.20.1741775896954;
        Wed, 12 Mar 2025 03:38:16 -0700 (PDT)
Received: from nuoska (78-27-76-97.bb.dnainternet.fi. [78.27.76.97])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5498ae45fbfsm2087312e87.5.2025.03.12.03.38.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 03:38:16 -0700 (PDT)
Date: Wed, 12 Mar 2025 12:38:13 +0200
From: Mikko Rapeli <mikko.rapeli@linaro.org>
To: yocto-patches@lists.yoctoproject.org
Cc: Omri Sarig <omri.sarig13@gmail.com>
Subject: Re: [yocto-patches] [PATCH v2 3/3] oeqa/cases/tpm2: Add
 tpm2-pkcs11-tools sanity test
Message-ID: <Z9FkFWK5JCRTELe9@nuoska>
References: <20250312103241.2526274-1-omri.sarig13@gmail.com>
 <20250312103241.2526274-4-omri.sarig13@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250312103241.2526274-4-omri.sarig13@gmail.com>
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 12 Mar 2025 10:38:28 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1194

Hi,

On Wed, Mar 12, 2025 at 11:32:41AM +0100, Omri Sarig via lists.yoctoproject.org wrote:
> Add a very simple sanity test, which ensures that tpm2_ptool can run
> without problems when the relevant package is available.
> 
> This test case is available here to help prevent future errors, where
> the tool is unable to run after installation, due to missing
> dependencies for example.
> 
> Contrary to other tests in the file, this test does not communicate with
> the TPM module itself, it only ensures that the tool (tpm2_ptool) can be
> loaded without any errors. Therefore, we don't need to depend on
> anything other than having the package installed.
> 
> Signed-off-by: Omri Sarig <omri.sarig13@gmail.com>
> ---
>  meta-tpm/lib/oeqa/runtime/cases/tpm2.py | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/meta-tpm/lib/oeqa/runtime/cases/tpm2.py b/meta-tpm/lib/oeqa/runtime/cases/tpm2.py
> index 8e90dc9..c2e6dfa 100644
> --- a/meta-tpm/lib/oeqa/runtime/cases/tpm2.py
> +++ b/meta-tpm/lib/oeqa/runtime/cases/tpm2.py
> @@ -67,3 +67,8 @@ class Tpm2Test(OERuntimeTestCase):
>      def test_tpm2_swtpm_reset(self):
>           (status, output) = self.target.run('swtpm_ioctl -i --tcp :2322')
>           self.assertEqual(status, 0, msg="swtpm reset failed: %s" % output)
> +
> +    @OEHasPackage(['tpm2-pkcs11-tools'])
> +    def test_tpm2_pkcs11_tools(self):
> +        (status, output) = self.target.run("tpm2_ptool --help")
> +        self.assertEqual(status, 0, msg="Module cannot be run with error: %s" % output)

Thanks! This good to start with. I think it's a separate question now if
meta-tpm test images will include tpm2-pkcs11-tools and actually run
this test.

Cheers,

-Mikko

