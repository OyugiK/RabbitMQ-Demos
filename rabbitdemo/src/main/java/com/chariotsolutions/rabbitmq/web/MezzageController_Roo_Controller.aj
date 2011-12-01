// WARNING: DO NOT EDIT THIS FILE. THIS FILE IS MANAGED BY SPRING ROO.
// You may push code into the target .java compilation unit if you wish to edit any member(s).

package com.chariotsolutions.rabbitmq.web;

import com.chariotsolutions.rabbitmq.domain.Mezzage;
import com.chariotsolutions.rabbitmq.service.MezzageService;
import java.io.UnsupportedEncodingException;
import java.util.Collection;
import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.util.UriUtils;
import org.springframework.web.util.WebUtils;

privileged aspect MezzageController_Roo_Controller {
    
    @Autowired
    MezzageService MezzageController.mezzageService;
    
    @RequestMapping(method = RequestMethod.POST)
    public java.lang.String MezzageController.create(@Valid Mezzage mezzage, BindingResult bindingResult, Model uiModel, HttpServletRequest httpServletRequest) {
        if (bindingResult.hasErrors()) {
            uiModel.addAttribute("mezzage", mezzage);
            return "mezzages/create";
        }
        uiModel.asMap().clear();
        mezzageService.saveMezzage(mezzage);
        return "redirect:/mezzages/" + encodeUrlPathSegment(mezzage.getId().toString(), httpServletRequest);
    }
    
    @RequestMapping(params = "form", method = RequestMethod.GET)
    public java.lang.String MezzageController.createForm(Model uiModel) {
        uiModel.addAttribute("mezzage", new Mezzage());
        return "mezzages/create";
    }
    
    @RequestMapping(value = "/{id}", method = RequestMethod.GET)
    public java.lang.String MezzageController.show(@PathVariable("id") java.lang.Long id, Model uiModel) {
        uiModel.addAttribute("mezzage", mezzageService.findMezzage(id));
        uiModel.addAttribute("itemId", id);
        return "mezzages/show";
    }
    
    @RequestMapping(method = RequestMethod.GET)
    public java.lang.String MezzageController.list(@RequestParam(value = "page", required = false) java.lang.Integer page, @RequestParam(value = "size", required = false) java.lang.Integer size, Model uiModel) {
        if (page != null || size != null) {
            int sizeNo = size == null ? 10 : size.intValue();
            final int firstResult = page == null ? 0 : (page.intValue() - 1) * sizeNo;
            uiModel.addAttribute("mezzages", mezzageService.findMezzageEntries(firstResult, sizeNo));
            float nrOfPages = (float) mezzageService.countAllMezzages() / sizeNo;
            uiModel.addAttribute("maxPages", (int) ((nrOfPages > (int) nrOfPages || nrOfPages == 0.0) ? nrOfPages + 1 : nrOfPages));
        } else {
            uiModel.addAttribute("mezzages", mezzageService.findAllMezzages());
        }
        return "mezzages/list";
    }
    
    @RequestMapping(method = RequestMethod.PUT)
    public java.lang.String MezzageController.update(@Valid Mezzage mezzage, BindingResult bindingResult, Model uiModel, HttpServletRequest httpServletRequest) {
        if (bindingResult.hasErrors()) {
            uiModel.addAttribute("mezzage", mezzage);
            return "mezzages/update";
        }
        uiModel.asMap().clear();
        mezzageService.updateMezzage(mezzage);
        return "redirect:/mezzages/" + encodeUrlPathSegment(mezzage.getId().toString(), httpServletRequest);
    }
    
    @RequestMapping(value = "/{id}", params = "form", method = RequestMethod.GET)
    public java.lang.String MezzageController.updateForm(@PathVariable("id") java.lang.Long id, Model uiModel) {
        uiModel.addAttribute("mezzage", mezzageService.findMezzage(id));
        return "mezzages/update";
    }
    
    @RequestMapping(value = "/{id}", method = RequestMethod.DELETE)
    public java.lang.String MezzageController.delete(@PathVariable("id") java.lang.Long id, @RequestParam(value = "page", required = false) java.lang.Integer page, @RequestParam(value = "size", required = false) java.lang.Integer size, Model uiModel) {
        Mezzage mezzage = mezzageService.findMezzage(id);
        mezzageService.deleteMezzage(mezzage);
        uiModel.asMap().clear();
        uiModel.addAttribute("page", (page == null) ? "1" : page.toString());
        uiModel.addAttribute("size", (size == null) ? "10" : size.toString());
        return "redirect:/mezzages";
    }
    
    @ModelAttribute("mezzages")
    public Collection<Mezzage> MezzageController.populateMezzages() {
        return mezzageService.findAllMezzages();
    }
    
    java.lang.String MezzageController.encodeUrlPathSegment(java.lang.String pathSegment, HttpServletRequest httpServletRequest) {
        String enc = httpServletRequest.getCharacterEncoding();
        if (enc == null) {
            enc = WebUtils.DEFAULT_CHARACTER_ENCODING;
        }
        try {
            pathSegment = UriUtils.encodePathSegment(pathSegment, enc);
        } catch (UnsupportedEncodingException uee) {}
        return pathSegment;
    }
    
}