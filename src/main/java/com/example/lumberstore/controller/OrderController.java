package com.example.lumberstore.controller;

import com.example.lumberstore.additional.JsonResponse;
import com.example.lumberstore.additional.enums.OrderStatus;
import com.example.lumberstore.entity.*;
import com.example.lumberstore.exceptions.notFoundExceptions.OrderAccessDeniedException;
import com.example.lumberstore.service.LocaleMessageHandler;
import com.example.lumberstore.service.interfaces.CatalogService;
import com.example.lumberstore.service.interfaces.OrderService;
import com.example.lumberstore.validation.OrderValidator;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.support.PagedListHolder;
import org.springframework.http.HttpStatus;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@RequestMapping("/order")
public class OrderController {

    private final OrderService orderService;
    private final OrderValidator orderValidator;
    private final LocaleMessageHandler localeMessageHandler;
    private final CatalogService catalogService;

    @Autowired
    public OrderController(OrderService orderService,
                           OrderValidator orderValidator,
                           LocaleMessageHandler localeMessageHandler,
                           CatalogService catalogService) {

        this.orderService = orderService;
        this.orderValidator = orderValidator;
        this.localeMessageHandler = localeMessageHandler;
        this.catalogService = catalogService;
    }

    @InitBinder(value = "order")
    protected void initBinder(WebDataBinder binder) {

        binder.setValidator(orderValidator);
    }

    @GetMapping("/all")
    public ModelAndView orders(@RequestParam(defaultValue = "all") String filter,
                               @RequestParam(defaultValue = "1") Integer page,
                               @ModelAttribute("message") String message,
                               @ModelAttribute("status") String status) {

        ModelAndView modelAndView = new ModelAndView("/admin/orders/list");

        PagedListHolder<Order> pagedListHolder = new PagedListHolder<>(orderService.getOrders(filter));
        pagedListHolder.setPage(page - 1);
        pagedListHolder.setPageSize(15);

        modelAndView.addObject("orders", pagedListHolder);
        modelAndView.addObject("orderStatusCount", orderService.getOrderStatusCount());
        modelAndView.addObject("expiredOrderCount", orderService.getExpiredOrderCount());

        modelAndView.addObject("message", message);
        modelAndView.addObject("status", status);

        return modelAndView;
    }

    @GetMapping("/history")
    public ModelAndView ordersHistory(@RequestParam(defaultValue = "1") Integer page,
                                      Authentication authentication) {

        ModelAndView modelAndView = new ModelAndView("/user/orderHistory");

        User currentUser = ((CustomUserDetails) authentication.getPrincipal()).getUser();

        PagedListHolder<Order> pagedListHolder = new PagedListHolder<>(
                orderService.getOrdersByCustomer(currentUser.getCustomer()));
        pagedListHolder.setPage(page - 1);
        pagedListHolder.setPageSize(5);

        modelAndView.addObject("orders", pagedListHolder);

        return modelAndView;
    }

    @GetMapping("/")
    public ModelAndView orderAdd() {

        return new ModelAndView("redirect:/calculator/");
    }

    @GetMapping(value = "/{id}")
    public ModelAndView showOrder(@PathVariable("id") Long id,
                                  @ModelAttribute("message") String message,
                                  @ModelAttribute("status") String status) {


        ModelAndView modelAndView = new ModelAndView("/admin/orders/show");

        Order order = orderService.getOrderById(id);

        modelAndView.addObject("order", order);

        modelAndView.addObject("message", message);
        modelAndView.addObject("status", status);


        return modelAndView;
    }

    @GetMapping("/{id}/update")
    public ModelAndView updateOrder(@PathVariable("id") Long id,
                                    final RedirectAttributes redirectAttributes) {

        ModelAndView modelAndView = new ModelAndView();

        Order order = orderService.getOrderById(id);

        if (order.getStatus() == OrderStatus.CLOSED) {

            modelAndView.setViewName("redirect:/order/" + id);
            redirectAttributes.addFlashAttribute("message",
                    localeMessageHandler.getMessage("message.notification.order.update.failure"));
            redirectAttributes.addFlashAttribute("status", "danger");

        } else {

            modelAndView.setViewName("redirect:/calculator/");
            redirectAttributes.addFlashAttribute("order", order);
        }

        return modelAndView;
    }

    @PostMapping(value = "/{id}/status")
    public ModelAndView updateStatus(@PathVariable("id") Long id,
                                     @RequestParam("status") OrderStatus status,
                                     final RedirectAttributes redirectAttributes) {

        ModelAndView modelAndView = new ModelAndView("redirect:/order/" + id);

        try {

            orderService.updateOrderStatus(id, status);
            redirectAttributes.addFlashAttribute("message",
                    localeMessageHandler.getMessage("message.notification.order.status.success"));
            redirectAttributes.addFlashAttribute("status", "success");

        } catch (OrderAccessDeniedException exception) {

            redirectAttributes.addFlashAttribute("message",
                    localeMessageHandler.getMessage("message.notification.order.status.failure"));
            redirectAttributes.addFlashAttribute("status", "danger");
        }

        return modelAndView;
    }

    @PostMapping("/{id}/delete")
    public ModelAndView deleteOrder(@PathVariable("id") Long id,
                                    @RequestParam(required = false) Integer page,
                                    @RequestParam(required = false) String filter,
                                    final RedirectAttributes redirectAttributes) {

        ModelAndView modelAndView = new ModelAndView("redirect:/order/all?filter=" + filter + "&page=" + page);

        orderService.deleteOrder(id);

        redirectAttributes.addFlashAttribute("message",
                localeMessageHandler.getMessage("message.notification.order.delete.success"));
        redirectAttributes.addFlashAttribute("status", "success");

        return modelAndView;
    }

    @PostMapping("/")
    @ResponseBody
    public JsonResponse saveOrder(@RequestBody @Validated Order order,
                                  BindingResult result) {

        JsonResponse response = new JsonResponse();

        if (result.hasErrors()) {
            response.setStatus(HttpStatus.BAD_REQUEST);
            response.setResult(result.getAllErrors());
            return response;
        }

        response.setStatus(HttpStatus.OK);
        response.setRedirect(true);

        if (order.isNew()) {
            orderService.addOrder(order);
            response.setRedirectUrl("/customer/add?orderId=" + order.getId());
        } else {
            orderService.updateOrder(order);
            response.setRedirectUrl("/order/" + order.getId());
        }

        return response;
    }

    @GetMapping("/fillByCatalog/{id}")
    public ModelAndView createOrderByTemplate(@PathVariable("id") Long id,
                                              RedirectAttributes redirectAttributes) {

        ModelAndView modelAndView = new ModelAndView("redirect:/calculator/");

        Catalog catalog = catalogService.getItemById(id);
        Order order = orderService.createOrder(catalog);

        redirectAttributes.addFlashAttribute("order", order);

        return modelAndView;
    }

}
