// WARNING: DO NOT EDIT THIS FILE. THIS FILE IS MANAGED BY SPRING ROO.
// You may push code into the target .java compilation unit if you wish to edit any member(s).

package com.aa.aa.web;

import com.aa.aa.domain.Bill;
import com.aa.aa.web.BillController;
import java.io.UnsupportedEncodingException;
import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.util.UriUtils;
import org.springframework.web.util.WebUtils;

privileged aspect BillController_Roo_Controller {
    
    @RequestMapping(method = RequestMethod.POST, produces = "text/html")
    public String BillController.create(@Valid Bill bill, BindingResult bindingResult, Model uiModel, HttpServletRequest httpServletRequest) {
        if (bindingResult.hasErrors()) {
            populateEditForm(uiModel, bill);
            return "bills/create";
        }
        uiModel.asMap().clear();
        bill.persist();
        return "redirect:/bills/" + encodeUrlPathSegment(bill.getId().toString(), httpServletRequest);
    }
    
    @RequestMapping(params = "form", produces = "text/html")
    public String BillController.createForm(Model uiModel) {
        populateEditForm(uiModel, new Bill());
        return "bills/create";
    }
    
    @RequestMapping(value = "/{id}", produces = "text/html")
    public String BillController.show(@PathVariable("id") Long id, Model uiModel) {
        uiModel.addAttribute("bill", Bill.findBill(id));
        uiModel.addAttribute("itemId", id);
        return "bills/show";
    }
    
    @RequestMapping(produces = "text/html")
    public String BillController.list(@RequestParam(value = "page", required = false) Integer page, @RequestParam(value = "size", required = false) Integer size, @RequestParam(value = "sortFieldName", required = false) String sortFieldName, @RequestParam(value = "sortOrder", required = false) String sortOrder, Model uiModel) {
        if (page != null || size != null) {
            int sizeNo = size == null ? 10 : size.intValue();
            final int firstResult = page == null ? 0 : (page.intValue() - 1) * sizeNo;
            uiModel.addAttribute("bills", Bill.findBillEntries(firstResult, sizeNo, sortFieldName, sortOrder));
            float nrOfPages = (float) Bill.countBills() / sizeNo;
            uiModel.addAttribute("maxPages", (int) ((nrOfPages > (int) nrOfPages || nrOfPages == 0.0) ? nrOfPages + 1 : nrOfPages));
        } else {
            uiModel.addAttribute("bills", Bill.findAllBills(sortFieldName, sortOrder));
        }
        return "bills/list";
    }
    
    @RequestMapping(method = RequestMethod.PUT, produces = "text/html")
    public String BillController.update(@Valid Bill bill, BindingResult bindingResult, Model uiModel, HttpServletRequest httpServletRequest) {
        if (bindingResult.hasErrors()) {
            populateEditForm(uiModel, bill);
            return "bills/update";
        }
        uiModel.asMap().clear();
        bill.merge();
        return "redirect:/bills/" + encodeUrlPathSegment(bill.getId().toString(), httpServletRequest);
    }
    
    @RequestMapping(value = "/{id}", params = "form", produces = "text/html")
    public String BillController.updateForm(@PathVariable("id") Long id, Model uiModel) {
        populateEditForm(uiModel, Bill.findBill(id));
        return "bills/update";
    }
    
    @RequestMapping(value = "/{id}", method = RequestMethod.DELETE, produces = "text/html")
    public String BillController.delete(@PathVariable("id") Long id, @RequestParam(value = "page", required = false) Integer page, @RequestParam(value = "size", required = false) Integer size, Model uiModel) {
        Bill bill = Bill.findBill(id);
        bill.remove();
        uiModel.asMap().clear();
        uiModel.addAttribute("page", (page == null) ? "1" : page.toString());
        uiModel.addAttribute("size", (size == null) ? "10" : size.toString());
        return "redirect:/bills";
    }
    
    void BillController.populateEditForm(Model uiModel, Bill bill) {
        uiModel.addAttribute("bill", bill);
    }
    
    String BillController.encodeUrlPathSegment(String pathSegment, HttpServletRequest httpServletRequest) {
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
