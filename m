Return-Path: <mikko.rapeli@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2B51C28B2F
	for <webhook@archiver.kernel.org>; Wed, 12 Mar 2025 11:15:18 +0000 (UTC)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
 by mx.groups.io with SMTP id smtpd.web11.34672.1741778111522498217
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 12 Mar 2025 04:15:11 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=MwvZDzUO;
 spf=pass (domain: linaro.org, ip: 209.85.167.48, mailfrom: mikko.rapeli@linaro.org)
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5497e7bf2e0so6495155e87.3
        for <yocto-patches@lists.yoctoproject.org>; Wed, 12 Mar 2025 04:15:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741778110; x=1742382910; darn=lists.yoctoproject.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XiEMIP708taTfq8tv6KTLN0mnPoCSjA6+bB2F9n4aYQ=;
        b=MwvZDzUOYK3nbUNvjyxLspmVehK1DVn+cEF/ViY7Z+WwR6IO0GoShRUFzKGF6YgHc8
         C8X2/Eq9TKZokoUsY2+wI5Q6zbO9XoMBZ24BYgMcC8cGs+kKhv+UVZxyLm689j++w7Sw
         uc7AYJI9gksguKRgtXWJhsU8qD3SNqqF8EgO2obVRJ8FBfGGUtCD2I/Lnp6B3IPAZ4Kr
         TR3Q+P+s0OLZ/ZMCC+KDViKibMfl7OpG3GwobRpU//9gl0VlyCj7FcMagKsXpNA8Hw01
         d3jM7UEugvjZfmGqXJQZx1gzUi8py5JDGR9QMusayQ5IL9jrKXsCpVJOaLQuryhiY3R3
         Yqzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741778110; x=1742382910;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XiEMIP708taTfq8tv6KTLN0mnPoCSjA6+bB2F9n4aYQ=;
        b=DP4IRS7q3ypLDOuQJlgnXhUb7d7C5/4QUER8314+y4vEYSdOfOWym8jitIlqqQevii
         XUj6A5a8l390SdxVDygx8vecDIaE/XsxLjsWePVbvDWMq7znPRlGEnsXKWKTH4qHfZgl
         AJ2SiGl9lVOB3wupnCSoOE5Fd5OmDtMTdIsb29fjBrHKXZO4cN5sXYaGToI85VRbLHf4
         N4CUwILC3TJLyfBBkpZw/yPVGMl3v1m2A/PJ9OjO0UnQNg86hGesjqSTErF5BzIlmWB+
         C8xTo4tFI3UeyzaHtuNQYyEwocB7KCZeWM7qxDw7D8EuVHCsTwibP1WmMOIT0sVWRVpZ
         DqnQ==
X-Gm-Message-State: AOJu0YwWwp57nYf62lvb4BGum9kNEL6CdRVdq8at0uH/63Tmaz9FPKPE
	h9HoIl6YNKixZA7+eXnBJngdsM2y0IBQLh31CP+AkCWEDFeTSaza1W+oPkhNJjCmfAiEQoO+W3l
	GUaY=
X-Gm-Gg: ASbGncvQoNFLzXRSHhlS3pELyOQE0s1hVXdg7LgxAB2qThxGhXj0hoEvzFJW8IiCtzx
	zo5MLGseYnwN9UzRM0HWyn4fQfv/7XR9ca9ogvAKukBruxQHG9GlPg/CHJwj2x1zqOG4RNjvNUH
	OJ8QLiH+yuu4DUnSBBW3fB6TStXOk90EpULBNYIYdUWxRgkPgPTHEmiWkQTkEtG+pOOqk6xKVSj
	pYjGjgzg/xlyQdvO6eFlnMS89eYcIKBxSdseNTRqfb65/97PAFgUPpqz9+jRiIXzGSGCZjNUJ+k
	0CQ6mkQARasxc7RoTuLut7iC/yTlrgdcjnf81+W+Aop2ksUUVvIayCsufj4oQmLmf4e4ww==
X-Google-Smtp-Source: AGHT+IEYhfI2GTRIHwqmTIuYbpzw1EdZxICA9mF7lJPRzPrfFPyTczoh9ZUA1LWD1dlGfWHD/G0r8w==
X-Received: by 2002:a05:6512:3d89:b0:549:8d8d:2c62 with SMTP id 2adb3069b0e04-549abae7207mr2324028e87.36.1741778109586;
        Wed, 12 Mar 2025 04:15:09 -0700 (PDT)
Received: from nuoska (78-27-76-97.bb.dnainternet.fi. [78.27.76.97])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5498ae46601sm2093413e87.1.2025.03.12.04.15.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 04:15:07 -0700 (PDT)
Date: Wed, 12 Mar 2025 13:15:05 +0200
From: Mikko Rapeli <mikko.rapeli@linaro.org>
To: Omri Sarig <omri.sarig13@gmail.com>
Cc: yocto-patches@lists.yoctoproject.org
Subject: Re: [yocto-patches] [PATCH v2 3/3] oeqa/cases/tpm2: Add
 tpm2-pkcs11-tools sanity test
Message-ID: <Z9FsubzQXInmctnY@nuoska>
References: <20250312103241.2526274-1-omri.sarig13@gmail.com>
 <20250312103241.2526274-4-omri.sarig13@gmail.com>
 <Z9FkFWK5JCRTELe9@nuoska>
 <ff0fda36-0658-4e5f-83e6-917908884c4f@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ff0fda36-0658-4e5f-83e6-917908884c4f@gmail.com>
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 12 Mar 2025 11:15:18 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1196

Hi,

On Wed, Mar 12, 2025 at 12:07:29PM +0100, Omri Sarig wrote:
> On 3/12/25 11:38, Mikko Rapeli wrote:
> > Hi,
> 
> Thanks for the fast reply!
> 
> > 
> > On Wed, Mar 12, 2025 at 11:32:41AM +0100, Omri Sarig via lists.yoctoproject.org wrote:
> > > Add a very simple sanity test, which ensures that tpm2_ptool can run
> > > without problems when the relevant package is available.
> > > 
> > > This test case is available here to help prevent future errors, where
> > > the tool is unable to run after installation, due to missing
> > > dependencies for example.
> > > 
> > > Contrary to other tests in the file, this test does not communicate with
> > > the TPM module itself, it only ensures that the tool (tpm2_ptool) can be
> > > loaded without any errors. Therefore, we don't need to depend on
> > > anything other than having the package installed.
> > > 
> > > Signed-off-by: Omri Sarig <omri.sarig13@gmail.com>
> > > ---
> > >   meta-tpm/lib/oeqa/runtime/cases/tpm2.py | 5 +++++
> > >   1 file changed, 5 insertions(+)
> > > 
> > > diff --git a/meta-tpm/lib/oeqa/runtime/cases/tpm2.py b/meta-tpm/lib/oeqa/runtime/cases/tpm2.py
> > > index 8e90dc9..c2e6dfa 100644
> > > --- a/meta-tpm/lib/oeqa/runtime/cases/tpm2.py
> > > +++ b/meta-tpm/lib/oeqa/runtime/cases/tpm2.py
> > > @@ -67,3 +67,8 @@ class Tpm2Test(OERuntimeTestCase):
> > >       def test_tpm2_swtpm_reset(self):
> > >            (status, output) = self.target.run('swtpm_ioctl -i --tcp :2322')
> > >            self.assertEqual(status, 0, msg="swtpm reset failed: %s" % output)
> > > +
> > > +    @OEHasPackage(['tpm2-pkcs11-tools'])
> > > +    def test_tpm2_pkcs11_tools(self):
> > > +        (status, output) = self.target.run("tpm2_ptool --help")
> > > +        self.assertEqual(status, 0, msg="Module cannot be run with error: %s" % output)
> > Thanks! This good to start with. I think it's a separate question now if
> > meta-tpm test images will include tpm2-pkcs11-tools and actually run
> > this test.
> 
> I've looked into it now.
> If I understand it correctly, and the image used for testing is
> security-tpm2-image
> (meta-security/meta-tpm/recipes-core/images/security-tpm2-image.bb), then
> the image already have tpm2-pkcs11-tools implicitly installed in it.
> 
> This is done as the image have the recipe of swtpm and the config of gnutls,
> which adds tpm2-pkcs11-tools to the runtime dependencies of swtpm.
> 
> I think we can do one of the following:
> 
> 1. Update the image to explicitly install tpm2-pkcs11-tools (as a package in
> IMAGE_INSTALL).
> 2. Update the commit message to add the above explanation, so users will
> know that the tool is added to the image (and thus tested).
> 3. Leave the commits as-is.
> 
> What do you think makes the most sense?

If the image already has it then I think we can leave as is.

But Armin as the layer maintainer can decide.

Cheers,

-Mikko

